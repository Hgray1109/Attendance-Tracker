class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :confirmable, :trackable, :lockable, :omniauthable, omniauth_providers: [:github]

include Roleable


    def self.from_omniauth(access_token)
      data = access_token.info
      user = User.where(email: data['email'].downcase).first
      unless user
           user = User.create(
              email: data['email'],
              password: Devise.friendly_token[0,20]
           )
       end
       user.provider = access_token.provider
       user.uid = access_token.uid
       user.name = data.name
       user.image = data.image
       user.save

       user.confirmed_at = Time.now
       user
    end

end
