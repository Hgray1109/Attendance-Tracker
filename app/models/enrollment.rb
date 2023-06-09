class Enrollment  < ApplicationRecord

    belongs_to :user
    belongs_to :course

    validates_uniqueness_of :user_id, scope: :course_id
    validates_uniqueness_of :course_id, scope: :user_id 

    validate :can_not_be_enrolled_in_own_course

    def can_not_be_enrolled_in_own_course
        if user_id.present?
            if user_id == course.user_id
                errors.add(:user_id, "Cannot be enrolled in own course")
            end
        end
    end
  
    def to_s
        id
    end
  
  end
  