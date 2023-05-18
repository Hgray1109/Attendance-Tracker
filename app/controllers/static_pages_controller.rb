class StaticPagesController < ApplicationController
  
  def landing_page
  end

  def privacy_policy
  end

  def calendar
    @lessons = Lesson.all
  end

end
