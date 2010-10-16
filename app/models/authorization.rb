class Authorization
  include MongoMapper::EmbeddedDocument
  
  key :provider, String
  key :uid, String
  
  validates_uniqueness_of :uid, :scope => :provider
end