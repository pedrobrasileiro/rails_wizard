class Recipe
  include MongoMapper::Document
  
  key :name, String
  key :slug, String
  key :description, String
  key :priority, Float
  key :code, String
  
  many :fields
  
  validates_presence_of :name, :slug
  
  def self.from_param(param)
    Recipe.find_by_slug(param)
  end
  
  def to_param
    slug
  end
end