class CreateCurriculas < ActiveRecord::Migration[5.2]
  def change
    create_table :curriculas do |t|
      t.belongs_to :graduations, index: true
      t.belongs_to :course_instances, index: true
    end
  end
end
