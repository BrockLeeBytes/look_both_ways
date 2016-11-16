class AddFormattedAddressToIntersections < ActiveRecord::Migration[5.0]
  def change
    add_column :intersections, :formatted_address, :string
  end
end
