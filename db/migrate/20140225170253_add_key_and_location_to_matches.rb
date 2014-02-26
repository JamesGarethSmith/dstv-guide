class AddKeyAndLocationToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :key, :string
    add_column :matches, :location, :string
  end
end
