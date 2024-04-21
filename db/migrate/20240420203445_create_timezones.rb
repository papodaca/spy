class CreateTimezones < ActiveRecord::Migration[7.1]
  def change
    create_table :timezones, id: :uuid do |t|
      t.text :name
      t.geometry :shape

      t.timestamps
    end
  end
end
