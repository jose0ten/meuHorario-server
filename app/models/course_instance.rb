class CourseInstance < ApplicationRecord
  belongs_to :course
  has_many :timeslot
  has_and_belongs_to_many :graduation
end
