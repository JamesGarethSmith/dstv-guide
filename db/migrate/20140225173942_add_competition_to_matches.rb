class AddCompetitionToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :competition, :string
  end
end
