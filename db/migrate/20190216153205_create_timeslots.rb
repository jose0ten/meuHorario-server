class CreateTimeslots < ActiveRecord::Migration[5.2]
  def change
    create_table :timeslots do |t|
      t.integer :day
      t.integer :starting_hour
      t.integer :ending_hour
      t.belongs_to :course_instance, index: true

      t.timestamps
    end
  end
end
