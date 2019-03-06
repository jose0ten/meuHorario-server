class CourseInstance < ApplicationRecord
  belongs_to :course
  has_many :timeslots
  has_and_belongs_to_many :graduations
end
