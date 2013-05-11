class CreateClass < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.integer :student_id
      t.integer :teacher_id
      t.timestamps

    end
  end
end