class Match < ActiveRecord::Base
  # starts_at: datetime
  # ends_at: datetime
  # title: string
  # channel_number: integer (index)
  # key: string
  # location: string
  # competition: string

  validates :starts_at, :ends_at, :key, presence: true
  belongs_to :channel, primary_key: :number, foreign_key: :channel_number

  scope :unset, where(title: nil)

  def self.coming
    where("ends_at > ?", Time.now)
  end

  def self.finished
    where("ends_at < ?", Time.now)
  end

  def self.clear_finished
    self.finished.find_each(&:destroy)
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