module Types
  class CourseInstancesType < BaseObject

    field :class_id, String, null: false
    field :timestamp, String, null: false
    field :professor, String, null: false
    field :date_semester, String, null: false

    field :course, CoursesType, null: false
    field :timeslot, TimeslotsType, null: false
    field :graduation, GraduationsType, null: false

    field :code, String, null: false

    def code
      self.course.code << '-' << self.class_id
    end

  end
end
