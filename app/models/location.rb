class Location
  include SchemeFinderFrontend::ApiEntity

  attr_accessor :id, :name, :group

  def to_s
    name
  end

  def self.collection
    all.group_by(&:group)
  end
end
