every :day, :at => '3am' do
  runner "DstvApi.update"
end

every :day, :at => '1am' do
  runner "Match.clear_finished"
end