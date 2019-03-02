class CreateCourseInstances < ActiveRecord::Migration[5.2]
  def change
    create_table :course_instances do |t|
      t.string :class_id
      t.string :timestamp
      t.string :professor
      t.string :date_semester
      t.belongs_to :course, index: true

      t.timestamps
    end
  end
end
