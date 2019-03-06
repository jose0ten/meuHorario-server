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


    field :all_course_instances, [CourseInstancesType], null: false do
      argument :professor, String, required: false, default_value: nil
    end

    def all_course_instances(professor:)
      response = CourseInstance.all
      if(professor)
        response = CourseInstance.where(professor: professor)
      end
      return response
    end

    field :all_graduations, [GraduationsType], null: false do
      argument :code, String, required: false, default_value: nil
    end

    def all_graduations(code:)
      response = Graduation.all
      if(code)
        response = Graduation.where(code: code)
      end
      #puts response[0].course_instances, "HELLO"
      return response
    end

    field :all_timeslots, [TimeslotsType], null: false

    def all_timeslots
      return response = Timeslot.all
    end

  end
end

