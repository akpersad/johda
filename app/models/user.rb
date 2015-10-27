class User < ActiveRecord::Base
  def self.find_or_create_from_auth_hash(auth_hash)
    #look up the user and create them
    user = where(provider: auth_hash[:provider], uid: auth_hash[:uid]).first_or_create
  end
end
