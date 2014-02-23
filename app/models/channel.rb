class Channel < ActiveRecord::Base
  # title: string
  # number: integer (index)
  validates :title, :number, presence: true, uniqueness: true
  has_many :matches, primary_key: :number, foreign_key: :channel_number

  def to_s
    title
  end
end