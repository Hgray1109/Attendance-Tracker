class Course < ApplicationRecord
  belongs_to :user
  belongs_to :classroom
  belongs_to :subject
  has_many :lessons, dependent: :destroy

  has_many :enrollments, inverse_of: :course, dependent: :destroy
  accepts_nested_attributes_for :enrollments, reject_if: :all_blank, allow_destroy: true

  has_many :attendances, through: :lessons

  include Schedulable

    def schedule 
      schedule = IceCube::Schedule.new(now = self.start_time&.to_datetime)
      schedule.add_recurrence_rule(
        IceCube::Rule.weekly.day(active_days)
      )
      schedule
    end

    def to_s
      id
    end

end
