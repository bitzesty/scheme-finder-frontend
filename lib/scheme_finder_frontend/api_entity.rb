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

      include HTTMultiParty
      base_uri SchemeFinderFrontend.api_url
      debug_output if SchemeFinderFrontend.debug_output

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
        case resp.code
        when 404
          raise ApiEntity::NotFound.new resp['error']
        when 500
          raise ApiEntity::Error.new resp['error']
        when 502
          raise ApiEntity::Error.new "502 Bad Gateway"
        end
      end

      def fetch_response_for(path, opts = {})
        resp = get(path, opts)
        raise_error_when_invalid_response(resp)

        resp
      end

      def all(opts = {})
        resp = fetch_response_for(collection_path, opts)

        records = if resp.is_a? Array
          resp
        else
          resp.with_indifferent_access[collection_name]
        end

        records.map { |entry_data| new(entry_data) }
      end

      def paginated(opts = {})
        resp = fetch_response_for(collection_path, opts).with_indifferent_access
        PaginationResponse.new resp[collection_name].map { |entry_data| new(entry_data) },
                               resp[:total],
                               resp[:page],
                               resp[:per_page]
      end

      def find(id, opts = {})
        resp = fetch_response_for("/#{self.name.pluralize.parameterize}/#{id}", opts)
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

      def collection_path(path = nil)
        if path
          @collection_path = path
        else
          @collection_path || "/#{collection_name}.json"
        end
      end

      def collection_name
        name.tableize
      end
    end
  end
end
