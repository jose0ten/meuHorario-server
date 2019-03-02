module Types
  class CourseInstancesType < BaseObject

    field :class_id, String, null: false
    field :timestamp, String, null: false
    field :professor, String, null: false
    field :date_semester, String, null: false
    field :course, CoursesType, null: false
    field :timeslots, [TimeslotsType], null: false

  end
end
