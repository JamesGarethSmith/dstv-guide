class Match < ActiveRecord::Base
  # starts_at: datetime
  # ends_at: datetime
  # title: string
  # channel_number: integer (index)

  validates :starts_at, :ends_at, :title, presence: true
  belongs_to :channel, primary_key: :number, foreign_key: :channel_number

  def self.coming
    where("ends_at > ?", Time.now)
  end

  def self.finished
    where("ends_at < ?", Time.now)
  end

  def to_s
    title
  end

  def now_on?
    self.starts_at.in_time_zone <= Time.now && self.ends_at.in_time_zone >= Time.now
  end

  def kickoff
    self.starts_at
  end

  def fulltime
    self.ends_at
  end
end