class Course < ApplicationRecord
  belongs_to :workload
  has_many :course_instance
end
