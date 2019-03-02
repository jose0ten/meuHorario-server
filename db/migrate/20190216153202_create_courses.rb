class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :code
      t.string :name
      t.string :course_type
      t.string :category
      t.integer :semester
      t.references :workload, foreign_key: true, null: true


      t.timestamps
    end
  end
end
