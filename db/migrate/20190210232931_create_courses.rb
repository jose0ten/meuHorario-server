class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :code
      t.string :name
      t.string :type
      t.string :category
      t.string :semester
      t.references :workload, foreign_key: true

      t.timestamps
    end
    add_index :courses, :code, unique: true
  end
end
