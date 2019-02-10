class CourseInstance < ApplicationRecord
  belongs_to :course
  belongs_to :timeslot
end
