class Authorization
  include MongoMapper::EmbeddedDocument
  
  key :provider, String
  key :uid, String
  
  validates_uniqueness_of :uid, :scope => :provider
  validates_presence_of :uid, :provider
end