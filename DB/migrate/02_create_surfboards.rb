class CreateSurfboards < ActiveRecord::Migration

  def change
    create_table :surfboards do |t|
      t.string :brand_name
      t.string :shaper
      t.string :length
      t.string :width
      t.string :thickness
      t.string :tail
      t.string :type_of_surf
      t.timestamps null: false
  end
end
