class User
  include MongoMapper::Document         

  many :authorizations
  key :name, String
  
  def self.from_hash(auth_hash)
    user = authorize(auth_hash['provider'], auth_hash['uid'])
    user ||= User.create(
      :name => auth_hash['user_info']['name'],
      :authorization => {
        :provider => auth_hash['provider'],
        :uid => auth_hash['uid']
      }
    )
  end
  
  def self.authorize(provider, uid)
    user.where('authorizations.provider' => provider, 'authorizations.uid' => uid).first
  end
end