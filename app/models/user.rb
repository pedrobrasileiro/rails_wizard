class User
  include MongoMapper::Document         

  one :authorization
  key :name, String
  
  has_many :recipes
  has_many :rails_templates
  
  def self.from_hash(auth_hash)
    user = authorize(auth_hash['provider'], auth_hash['uid'])
    user ||= User.create(
      :name => (auth_hash['user_info']['name'] rescue 'User'),
      :authorization => {
        :provider => auth_hash['provider'],
        :uid => auth_hash['uid']
      }
    )
  end
  
  def admin?
    false
  end
  
  def self.authorize(provider, uid)
    User.where('authorization.provider' => provider, 'authorization.uid' => uid).first
  end
end