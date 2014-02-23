class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :title
      t.integer :number

      t.timestamps
    end

    add_index :channels, :number
  end
end
