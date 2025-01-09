class Admin::UsersController < AdminController
        def index
                if params[:query].present?
                        @admin_users=User.where('email LIKE ?',"%#{params[:query]}%").order(created_at: :desc)  
                else
                @admin_users=User.all.order(created_at: :desc)
                end
        end
        def show 
                @admin_user=User.find(params[:id])
                @user_started_course=@admin_user.lesson_users&.joins(:lesson)&.pluck(:course_id)&.uniq
                @admin_courses=Course.where(id: @user_started_course)
                if @user_started_course.present?
                        @user_course_progreses=@user_started_course.map do |course_id|
                                course_lessons=Course.find(course_id)&.lessons.count
                                completed_lessons=@admin_user&.lesson_users&.joins(:lesson)&.where(completed: true,lesson:{course: course_id})&.count
                                {course_id:course_id,completedPercentage:(completed_lessons.to_f / course_lessons.to_f * 100).to_i}
                        end
                end
        end
        def destroy
                @user=User.find(params[:id])
                @user.destroy!
                redirect_to admin_users_path
        end
end
