module Types
  class CourseInstancesType < BaseObject

    field :class_id, String, null: false
    field :course, CoursesType, null: false
    field :timestamp, String, null: false
    field :timeslot, TimeslotsType, null: false
    field :date_semester, String, null: false
    field :professor, String, null: false

    field :code, String, null: false

  end
end
