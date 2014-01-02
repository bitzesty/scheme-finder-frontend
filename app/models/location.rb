require 'api_entity'

class Location
  include ApiEntity

  # collection_path "/updates/latest"

  attr_accessor :id, :name

  def to_s
    name
  end

  def self.collection
    all
  end
end
