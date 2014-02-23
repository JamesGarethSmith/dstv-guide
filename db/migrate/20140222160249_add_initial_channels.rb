class AddInitialChannels < ActiveRecord::Migration
  def change
    supersport3 = Channel.create!(title: "Supersport 3", number: 203)
    supersport5 = Channel.create!(title: "Supersport 5", number: 205)
    supersport7 = Channel.create!(title: "Supersport 7", number: 207)
  end
end
