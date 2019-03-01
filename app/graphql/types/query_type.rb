module Types
  class QueryType < Types::BaseObject

    field :test_field, String, null: false, description: "An example field added by the generator"

    def test_field
      'Oi rs'
    end

    field :all_courses, [CoursesType], null: false do
      argument :id, String, required: false, default_value: nil
    end

    def all_courses(id:)
      response = Course.all
      if id
        response = Course.where(code: id)
      end
      return response
    end

    field :all_workloads, [WorkloadsType], null: false

    def all_workloads
      return response = Workload.all
    end

    field :all_timeslots, [TimeslotsType], null: false

    def all_timeslots
      return response = Timeslot.all
    end

  end
end

