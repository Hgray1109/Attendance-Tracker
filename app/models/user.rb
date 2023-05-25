class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :confirmable, :trackable, :lockable, :invitable, 
         :omniauthable, omniauth_providers: [:github, :google_oauth2]

include Roleable


    def self.from_omniauth(access_token)
      data = access_token.info
      user = User.find_by(email: data['email'].downcase)
      unless user
           user = User.create(
              email: data['email'],
              password: Devise.friendly_token[0,20]
           )
       end
       user.provider = access_token.provider
       user.uid = access_token.uid
       unless user.name.present?
        user.name = data.name
       end
       user.image = data.image
       user.save

       user.confirmed_at = Time.now
       user
    end

    after_create do
      # assign default role to user
      self.update(student: true)
    end

    has_many :enrollments, dependent: :restrict_with_error
    has_many :lessons, dependent: :restrict_with_error
    has_many :attendances, dependent: :restrict_with_error
    has_many :courses, dependent: :restrict_with_error

    

    def total_attendance_price
      attendances.map(&:student_price_start).sum
    end

    monetize :total_attendance_price, as: :total_attendance_price_cents

    def to_s
      email
    end

    def to_label
      to_s
    end
end
