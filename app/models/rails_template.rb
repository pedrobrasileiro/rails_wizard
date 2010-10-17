class RailsTemplate
  include MongoMapper::Document         

  STEPS = %w(app_info orm testing javascript authentication)

  # Fields
  key :name, String
  key :slug, String
  key :listed, Boolean
  
  RECIPE_FIELDS = %w(orm unit_testing integration_testing javascript authentication)
  RECIPE_FIELDS.each{|f| key f, String}
  
  timestamps!
  
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
  
  def app_info?; !self.listed.nil? end
  def testing?; self.unit_testing? || self.integration_testing? end
  
  # Slug Generation
  before_validation :set_slug, :on => :create
  
  def set_slug
    if new_record? && self.slug.nil?
      self.slug = self.class.generate_private_slug
    end
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