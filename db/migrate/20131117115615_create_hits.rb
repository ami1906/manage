class CreateHits < ActiveRecord::Migration
  def change
    create_table :hits do |t|
      t.integer :count

      t.timestamps
    end
  end
end
