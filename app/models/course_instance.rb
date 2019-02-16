class CourseInstance < ApplicationRecord
  belongs_to :course
  has_many :timeslot
  has_many :curricula
  has_many :graduation, through: :curricula
end
