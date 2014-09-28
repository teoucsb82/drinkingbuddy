class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.date :start_time, :presence => true, :default => Time.now
      t.string :title
      t.text :description
      t.boolean :private, :default => false
      t.integer :user_id, :presence => true
      t.timestamps
    end
  end
end
