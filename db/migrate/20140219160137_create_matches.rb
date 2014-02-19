class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :title

      t.timestamps
    end
  end
end
