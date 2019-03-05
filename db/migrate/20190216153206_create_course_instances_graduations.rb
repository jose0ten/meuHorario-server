class CreateCourseInstancesGraduations < ActiveRecord::Migration[5.2]
  def change
    create_table :course_instances_graduations, id: false do |t|
      t.belongs_to :course_instance, index: true
      t.belongs_to :graduation, index: true
    end
  end
end
