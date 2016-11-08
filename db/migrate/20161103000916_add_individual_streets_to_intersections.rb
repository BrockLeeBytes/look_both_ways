class AddIndividualStreetsToIntersections < ActiveRecord::Migration[5.0]
  def change
    add_column :intersections, :street1, :string
    add_column :intersections, :street2, :string
  end
end
