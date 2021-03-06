module Types
  class CoursesType < BaseObject

    field :code, String, null: false
    field :name, String, null: false
    field :course_type, String, null: false
    field :category, String, null: false
    field :semester, String, null: false
    field :workload, WorkloadsType, null: true
    field :course_instances, [CourseInstancesType], null: false

    field :short_name, String, null: false

    def short_name
      toReplace = ['AS', 'NO', 'NA', 'EM', 'DO', 'DA', 'DE','O', 'A', 'E', 'AO', 'PARA', 'DOS', 'DAS', 'I', 'II', 'III', 'IV', 'V'];

      return self.object.name
                            .split(' ')
                            .select {|elemento| !toReplace.include?(elemento)}
                            .map{|i| i[0]}
                            .join('');
    end

  end
end
