class CreateWorkloads < ActiveRecord::Migration[5.2]
  def change
    create_table :workloads do |t|
      t.integer :classroom
      t.integer :lab
      t.integer :total

      t.timestamps
    end
  end
end
