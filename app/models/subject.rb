class Subject < ApplicationRecord

    has_many :courses, dependent: :restrict_with_error

    validates :name, presence: true, uniqueness: {case_sensitive: false }
    validates :duration, numericality: {greater_than_or_equal_to: 15, less_than_or_equal_to: 180, only_integer: true}
  

    monetize :client_price, as: :client_price_cents, numericality: {greater_than_or_equal_to: 50, less_than_or_equal_to: 10000}
    monetize :teacher_price, as: :teacher_price_cents, numericality: {greater_than_or_equal_to: 20, less_than_or_equal_to: 10000}

    def to_s
        name
    end
end
