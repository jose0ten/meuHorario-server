class CreateGraduations < ActiveRecord::Migration[5.2]
  def change
    create_table :graduations do |t|
      t.string :gradu_id
      t.string :code
      t.string :name
      t.string :faculty
      t.string :minch
      t.string :maxch
      t.integer :semesters
      t.references :courses, foreign_key: true

      t.timestamps
    end
  end
end
