class AdminController < ApplicationController
        before_action :authenticate_admin!
        require 'active_support/core_ext/time' #Needed for Rails 7 (and sometimes Rails 6)
require 'active_support/core_ext/date'
        def index
                @quick_status={
                        sign_ups:User.where('created_at > ?',1.week.ago).count,
                        sales:CourseUser.where('created_at  >?',1.week.ago).count,
                        completedLessons:LessonUser.where('created_at >?',1.week.ago).where(completed: true).count
                }
                @completedLessonsByDay=LessonUser.where('created_at >?',1.week.ago).where(completed: true).group("DATE(created_at)").count


                # @signUpsByDay=User.where('created_at >?',1.week.ago).where(completed: true).group("DATE(created_at)").count
                
                # signUpsByDay=User.where('created_at >?',1.week.ago).where(completed: true).group_by_day(:created_at, format: "%A").count

                @mostPopularCourses=Course.joins(:course_users).group(:id).order('count(course_users.id) desc').limit(10)
        end
end