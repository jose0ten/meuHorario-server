class Course < ApplicationRecord
  has_one :workload
  has_many :course_instance
end
