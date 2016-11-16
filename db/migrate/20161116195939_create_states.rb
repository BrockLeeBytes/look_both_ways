class CreateStates < ActiveRecord::Migration[5.0]
  def change
    create_table :states do |t|
      t.string :name
      t.string :postal_code
      t.text :cities, array: true, default: []

      t.timestamps
    end
  end
end
