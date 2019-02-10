class CreateCourseInstances < ActiveRecord::Migration[5.2]
  def change
    create_table :course_instances do |t|
      t.string :class_id
      t.references :course, foreign_key: true
      t.string :timestamp
      t.references :timeslot, foreign_key: true
      t.string :date_semester
      t.string :professor

      t.timestamps
    end
  end
end
