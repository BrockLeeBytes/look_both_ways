class AddIndexToReviews < ActiveRecord::Migration[5.0]
  def change
  	change_table :reviews do |t|
  		t.belongs_to :user, index: true
  		t.belongs_to :intersection, index: true
  	end
  end
end
