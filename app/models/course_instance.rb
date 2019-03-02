class CourseInstance < ApplicationRecord
  belongs_to :course
  has_many :timeslots
end
