class AddChannelToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :channel_number, :integer
    add_index :matches, :channel_number
  end
end
