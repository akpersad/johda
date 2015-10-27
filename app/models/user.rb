class User < ActiveRecord::Base
  def self.find_or_create_from_auth_hash(auth_hash)
    #look up the user and create them
    user = where(provider: auth_hash[:provider], uid: auth_hash[:uid]).first_or_create
    user.update(
        name: auth_hash[:info][:name]
        image: auth_hash[]
      )
  end
end
