class AddMultipleStreetsToIntersections < ActiveRecord::Migration[5.0]
  def change
    add_column :intersections, :street_one, :string
    add_column :intersections, :street_two, :string
  end
end
