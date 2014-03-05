class DstvApi
  include HTTParty
  base_uri 'http://www.dstv.com/guide/GuideAsyncHandler.ashx'

  def self.update
    6.times { |i| self.get_for_date(Date.today + i) }
    Match.unset.each { |match| self.set_match(match) }
  end

  def self.get_for_date(date)
    puts date
    # get events for date
    data = self.events(date).parsed_response["Channels"]
    # loop through channels
    data.each do |channel|
      channel_number = channel["Num"].to_i
      # loop through events
      channel["Schedules"].each do |event|
        # select those that are at least 7200 seconds long (2 hours) and are either premier or champions league
        if (event[3].downcase.match(/barclays premier league/) || event[3].downcase.match(/uefa champions league/)) && event[2].to_i >= 7200
          # create a match for those events
          puts event[3]
          puts Match.where(key: event[0]).present?

          Match.where("starts_at = ? AND channel_number = ?", Time.at(event[1].to_i, channel_number).first_or_create do |match|
            match.starts_at = Time.at(event[1].to_i)
            match.ends_at = Time.at(event[1].to_i) + event[2].to_i.seconds
            match.channel_number = channel_number
            match.competition = event[3].downcase.match(/barclays premier league/) ? "Barclays Premier League" : "UEFA Champions League"
          end
        end
      end
    end
  end

  def self.set_match(match)
    data = self.event_details(match.key).parsed_response

    if data["Synopsis"].downcase.match(/ live /)
      match.title = self.parse_title(data["Synopsis"])
      match.location = self.parse_location(data["Synopsis"])
      match.save!
    else
      match.destroy
    end
  end

  def self.parse_location(synopsis)
    starts = synopsis.index("from ") + 5
    length = synopsis.length - starts
    synopsis.slice(starts, length - 1)
  end

  def self.parse_title(synopsis)
    starts = synopsis.index("'") + 1
    ends = synopsis.index("'", starts) - 1
    synopsis.slice(starts, ends)
  end

  def self.event_details(key)
    self.get("?eventId=#{key}&method=GetEventDetails")
  end

  def self.events(date)
    channels = Channel.pluck(:number).join(",")
    self.get("?method=GetEventsByCountryChannelBouquet&channel=#{channels}&countryId=ZA&bouquet=1&channelType=video&date=#{date}")
  end
end