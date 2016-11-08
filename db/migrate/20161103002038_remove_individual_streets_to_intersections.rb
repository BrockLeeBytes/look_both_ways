class RemoveIndividualStreetsToIntersections < ActiveRecord::Migration[5.0]
  def change
    remove_column :intersections, :street1, :string
    remove_column :intersections, :street2, :string
  end
end
