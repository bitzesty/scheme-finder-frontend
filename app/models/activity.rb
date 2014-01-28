class Activity
  include SchemeFinderFrontend::ApiEntity

  attr_accessor :id, :name, :for_teachers, :for_businesses

  def to_s
    name
  end

  def self.collection
    all
  end
end
