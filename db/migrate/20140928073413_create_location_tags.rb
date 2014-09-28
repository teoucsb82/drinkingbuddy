class CreateLocationTags < ActiveRecord::Migration
  def change
    create_table :location_tags do |t|
      t.float :latitude
      t.float :longitude
      t.text :address
      t.references :locationable, polymorphic: true
      t.timestamps
    end
  end
end
