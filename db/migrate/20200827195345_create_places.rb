class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|
      t.string :place_id
      t.string :place
      t.string :country_id
      t.string :region_id
      t.string :city_id
      t.string :country

      t.timestamps
    end
  end
end
