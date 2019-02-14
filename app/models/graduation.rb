class Graduation < ApplicationRecord
  has_and_belongs_to_many :course_instance
end
