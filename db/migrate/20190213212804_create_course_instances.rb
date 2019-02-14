class CreateCourseInstances < ActiveRecord::Migration[5.2]
  def change
    create_table :course_instances do |t|
      t.string :class_id
      t.string :timestamp
      t.string :professor
      t.string :date_semester
      t.references :course, foreign_key: true

      t.timestamps
    end

    create_table :graduations_course_instances do |t|
      t.belongs_to :graduations, index: true
      t.belongs_to :course_instances, index: true
    end
  end
end
