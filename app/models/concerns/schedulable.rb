module Schedulable

    extend ActiveSupport::Concern
    included do
        # List user days
        DAYS_OF_THE_WEEK = [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]

        # json column to store roles
        store_accessor :days, *DAYS_OF_THE_WEEK

        # Cast roles to/from booleans
        DAYS_OF_THE_WEEK.each do |day|
            scope day, -> { where("days @> ?", {day => true}.to_json) }
            define_method(:"#{day}=") { |value| super ActiveRecord::Type::Boolean.new.cast(value) }
            define_method(:"#{day}?") { send(day) }
        end

        # Where value true
        def active_days
            DAYS_OF_THE_WEEK.select { |day| send(:"#{day}?") }.compact
        end

    end
end
