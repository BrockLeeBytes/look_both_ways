class RemoveStateFromIntersection < ActiveRecord::Migration[5.0]
  def change
  	remove_column :intersections, :state
  end
end
