module Types
  class GraduationsType < BaseObject

    field :gradu_id, String, null: false
    field :code, String, null: false
    field :name, String, null: false
    field :faculty, String, null: false
    field :minch, String, null: false
    field :maxch, String, null: false
    field :semesters, Integer, null: false

    field :course_instance, [CourseInstancesType], null: false
  end
end
