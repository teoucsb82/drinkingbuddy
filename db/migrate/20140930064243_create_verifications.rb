class CreateVerifications < ActiveRecord::Migration
  def change
    create_table :verifications do |t|
      t.integer :user_id, :presence => true
      t.integer :unique_id, :presence => true
      t.timestamps
    end
  end
end
