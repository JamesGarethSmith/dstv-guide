class GuideController < ApplicationController
  def index
    @matches = Match.coming.order("starts_at ASC")
  end
end