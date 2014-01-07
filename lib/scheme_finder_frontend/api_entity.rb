require 'httparty'
require 'pagination_response'

module SchemeFinderFrontend
  module ApiEntity
    class NotFound < StandardError; end
    class Error < StandardError; end

    extend ActiveSupport::Concern

    included do
      include ActiveModel::Validations
      include ActiveModel::Conversion
      extend  ActiveModel::Naming

      attr_reader :attributes, :errors

      attr_accessor :casted_by

      class_eval do
        def resource_path
          "/#{self.class.name.underscore.pluralize}/#{to_param}"
        end

        def to_param
          id
        end
      end
    end

    def initialize(attributes = {})
      @errors = ActiveModel::Errors.new(self)
      class_name = self.class.name.downcase

      attributes = HashWithIndifferentAccess.new(attributes)

      if attributes.present? && attributes.has_key?(class_name)
        @attributes = attributes[class_name]

        self.attributes = attributes[class_name]
      else
        @attributes = attributes

        self.attributes = attributes
      end
    end

    def attributes=(attributes = {})
      attributes.each do |name, value|
        if self.respond_to?(:"#{name}=")
          send(:"#{name}=", (value.is_a?(String) && value == "null") ? nil : value)
        end
      end if attributes.present?
    end

    def persisted?
      true
    end

    def assign_errors(errors = {})
      Hash(errors).each do |attribute, error_messages|
        Array(error_messages).each do |error_message|
          @errors.add(attribute, error_message)
        end
      end
    end
    private :assign_errors

    module ClassMethods
      def raise_error_when_invalid_response(resp)
        case resp.status
        when 404
          raise ApiEntity::NotFound.new resp['error']
        when 500
          raise ApiEntity::Error.new resp['error']
        when 502
          raise ApiEntity::Error.new "502 Bad Gateway"
        end
      end

      def fetch_response_for(path, opts = {})
        resp = SchemeFinderFrontend.api_client.get(path, opts)
        raise_error_when_invalid_response(resp)

        resp
      end

      def all(opts = {})
        # collection path parameters can be passed via opts
        resp = fetch_response_for collection_path(opts),
                                  opts

        records = if resp.body.is_a? Array
          resp.body
        else
          resp.body.with_indifferent_access[collection_name]
        end

        records.map { |entry_data| new(entry_data) }
      end

      def paginated(opts = {})
        resp = fetch_response_for(collection_path(opts),
                                  opts).body.with_indifferent_access

        PaginationResponse.new resp[collection_name].map { |entry_data| new(entry_data) },
                               resp[:total],
                               resp[:page],
                               resp[:per_page]
      end

      def find(id, opts = {})
        resp = fetch_response_for member_path(opts.merge(id: id)),
                                  opts
        new(resp)
      end

      def has_one(association, opts = {})
        options = opts.reverse_merge({ class_name: association.to_s.singularize.classify })

        attr_accessor association.to_sym

        class_eval <<-METHODS
          def #{association}=(data)
            data ||= {}

            @#{association} ||= #{options[:class_name]}.new(data.merge(casted_by: self))
          end
        METHODS
      end

      def has_many(associations, opts = {})
        options = opts.reverse_merge({ class_name: associations.to_s.singularize.classify,
                                       wrapper: Array })

        class_eval <<-METHODS
          def #{associations}
            #{options[:wrapper]}.new(@#{associations}.presence || [])
          end

          def #{associations}=(data)
            @#{associations} ||= if data.present?
              data.map { |record| #{options[:class_name]}.new(record.merge(casted_by: self)) }
            else
              []
            end
          end

          def add_#{associations.to_s.singularize}(record)
            @#{associations} ||= []
            @#{associations} << record
          end
        METHODS
      end

      def collection_path(opts = {})
        route_to_path collection_route, opts
      end

      def member_path(opts = {})
        route_to_path member_route, opts
      end

      def collection_route
        "#{collection_name}.json"
      end

      def member_route
        "#{collection_name}/:id.json"
      end

      def collection_name
        name.tableize
      end

      # replace route attributes with params provided
      # Given collection_route = "schemes/:scheme_id/feedbacks.json"
      # And params = { scheme_id: 3 }
      # path returned is "schemes/3/feedbacks.json"
      def route_to_path(route, params)
        params.each do |key, value|
          route.gsub! /\/:#{key}([\/\.])/, "/#{value}\\1"
        end

        route
      end
    end
  end
end
