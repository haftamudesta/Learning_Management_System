class Lesson < ApplicationRecord
  has_one_attached :image
  has_one_attached :video
  belongs_to :course
  has_many :lesson_users, dependent: :destroy
  acts_as_list
  has_rich_text :description
  def next_lesson
    course.lessons.where("position > ?",position).order(:position).first
  end
  def previous_lesson
    course.lessons.where("position < ?",position).order(:position).last
  end
end
