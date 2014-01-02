class Location
  include ApiEntity

  attr_accessor :id, :name

  def to_s
    name
  end

  def self.collection
    all
  end
end
