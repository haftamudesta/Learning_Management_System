class LessonsController < ApplicationController
  before_action :set_lesson, only: %i[ show update  ]
  before_action :set_course
  before_action :check_paid
  def show
    @completed_lessons=current_user.lesson_users.where(completed: true).pluck(:lesson_id)
    @course=@lesson.course
    @paid_for_course=current_user.course_users.where(course:@course).exists?
  end
  def update
    @lesson_user=LessonUser.find_or_create_by(user: current_user,lesson: @lesson)
    puts @lesson_user
    @lesson_user.update!(completed: true)
    puts "next lesson"
    next_lesson=@course.lessons.where("position >?",@lesson.position).order(:position).first
    puts "next lesson"
    puts next_lesson
    if next_lesson
      redirect_to course_lesson_path(@course,next_lesson)
    else
      redirect_to course_path(@course),notice:"You have Successfully completed the course"
    end
  end
  private
  def set_course
    @course=Course.find(params[:course_id])
  end
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end
    def check_paid
      if @lesson.paid && !current_user.course_users.where(course_id: params[:course_id]).exists?
        if @lesson.previous_lesson
          redirect_to course_lesson_path(@course,@lesson.previous_lesson),notice:"you must perchase the course to go to the next lesson"
        else
          redirect_to course_path(@course),notice:"you must perchase the course to go to the next lesson"
        end
      end
    end
end
