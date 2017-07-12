class CreateMacs < ActiveRecord::Migration[5.0]
  def change
    create_table :macs do |t|
      t.integer :start_time
      t.integer :end_time
      t.timestamps
    end
  end
end
