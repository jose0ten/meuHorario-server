class Graduation < ApplicationRecord
  has_many :curricula
  has_many :course_instance, through: :curricula
end
