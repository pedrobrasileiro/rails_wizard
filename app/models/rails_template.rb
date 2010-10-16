class RailsTemplate
  include MongoMapper::Document         

  # Fields
  key :name, String
  key :slug, String
  
  # Validations
  validates_presence_of :name, :slug
  validates_uniqueness_of :slug
  
  # Params
  def to_param
    self.slug
  end
  
  def self.from_param(slug)
    RailsTemplate.find_by_slug(slug)
  end
  
  # Slug Generation
  before_validation_on_create :set_slug
  
  def set_slug
    while self.slug.nil? || RailsTemplate.find_by_slug(self.slug)
      self.slug = self.class.generate_private_slug
    end
    self.slug
  end
  
  POOL = %w(x v l 5 4 b 8 i 1 z 9 t s 3 j c m n e d q k g y r 6 0 a f h w p 2 u o 7)
  def self.generate_slug(count = RailsTemplate.count)
    return if count < 0
    "#{generate_slug(((count / POOL.size) - 1))}#{POOL[count - ( (count / POOL.size) * POOL.size )]}"
  end
  
  def self.generate_private_slug
    ActiveSupport::SecureRandom.hex(10)
  end
end