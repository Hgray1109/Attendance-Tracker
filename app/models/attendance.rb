class Attendance < ApplicationRecord

    belongs_to :user
    belongs_to :lesson

    validates :status, presence: true

    validates_uniqueness_of :user_id, scope: :lesson_id
    validates_uniqueness_of :lesson_id, scope: :user_id 

    monetize :student_price_start, as: :student_price_start_cents

    STATUSES = [:planned, :attended, :not_attended]

    def self.statuses
      STATUSES.map { |status| [status, status]}
    end

    def to_s
        user
    end

    after_create do
        update_column :student_price_start, lesson.course.subject.client_price
    end
    
end
