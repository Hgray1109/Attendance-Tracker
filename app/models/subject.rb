class Subject < ApplicationRecord

    has_many :courses, dependent: :restrict_with_error

    validates :name, presence: true, uniqueness: {case_sensitive: false }
    validates :duration, numericality: {greater_than_or_equal_to: 30, less_than_or_equal_to: 180, only_integer: true}
    validates :client_price, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 10000}


    def to_s
        name
    end
end
