class Curricula < ApplicationRecord
  belongs_to :course_instance
  belongs_to :graduation
end
