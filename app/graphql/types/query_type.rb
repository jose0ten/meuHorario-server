module Types
  class QueryType < Types::BaseObject

    field :test_field, String, null: false, description: "An example field added by the generator"

    def test_field

      'Oi rs'

    end

    field :all_timeslots, [TimeslotsType], null: false

    def all_timeslots
      ::Timeslot.all
    end

    field :all_workloads, [WorkloadsType], null: false

    def all_workloads
      ::Workload.all
    end

    field :all_courses, [CoursesType], null: false do
      argument :id, String, required: false, default_value: false
    end

    def all_courses(id:)
      if id
        ::Course.where(code: id)
      else
        ::Course.all
      end
    end
    field :all_courseinstances, [CourseInstancesType], null: false

    def all_courseinstances
      ::CourseInstance.all
    end

    #return JSON.parse(text)['time'][0]['turmas'][0]
  end
end

