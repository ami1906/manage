class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :rollno
      t.string :firstname
      t.string :lastname
      t.integer :branch_id
      t.integer :gender_id
      t.string :status

      t.timestamps
    end
  end
end
