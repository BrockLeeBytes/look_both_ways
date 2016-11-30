class AddForeignKeyToIntersections < ActiveRecord::Migration[5.0]
  def change
  	add_reference :intersections, :state, index: true
  	add_foreign_key :intersections, :states
  end
end
