class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :course_type
      t.string :code
      t.integer :semester
      t.string :name
      t.string :category
      t.references :workload, foreign_key: true

      t.timestamps
    end
  end
end
