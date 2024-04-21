class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.references :timezone, type: :uuid, foreign_key: true
      t.float :lat
      t.float :lon
      t.float :acc
      t.float :alt
      t.float :vac
      t.st_point :gis_location, geographic: true
      t.datetime :recorded_at
      t.datetime :reported_at
      t.text :uid
      t.text :tid
      t.json :properties

      t.timestamps
    end
  end
end
