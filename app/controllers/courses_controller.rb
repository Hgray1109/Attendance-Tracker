class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy, :generate_lessons]

  # GET /courses or /courses.json
  def index
    @courses = Course.all
  end

  def generate_lessons
    # delete future lessons
    @course.lessons.where("start > ?", Time.now).destroy_all

    # regenerates future lessons
    @course.schedule.next_occurrences(4).each do |occurrence| 
      @course.lessons.find_or_create_by(start: occurrence, user: @course.user, classroom: @course.classroom)
    end

    # generate attendances for future lessons
    @course.lessons.where("start > ?", Time.now).each do |lesson|
      @course.enrollments.each do |enrollment|
        lesson.attendances.find_or_create_by(status: "planned", user: enrollment.user)
      end
    end
    redirect_to @course, notice: "generate_lessons - ok"
  end

  # GET /courses/1 or /courses/1.json
  def show
    @lessons = @course.lessons
    @enrollments = @course.enrollments
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to course_url(@course), notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to course_url(@course), notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
   if @course.destroy
      redirect_to courses_url, notice: "Course was successfully destroyed."
   else
      redirect_to courses_url, alert: "This Course has lessons and can not be deleted."
   end
  end

  private

    def set_course
      @course = Course.find(params[:id])
    end

 
    def course_params
      params.require(:course).permit(:user_id, :classroom_id, :subject_id, :start_time, 
        *Course::DAYS_OF_THE_WEEK,
        enrollments_attributes: [:id, :user_id, :_destroy])
    end
end
