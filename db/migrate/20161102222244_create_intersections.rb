class CreateIntersections < ActiveRecord::Migration[5.0]
  def change
    create_table :intersections do |t|
      t.string :streets
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
