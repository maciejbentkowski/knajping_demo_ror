class PagesController < ApplicationController
  def index
    @top_reviewer = User.best_reviewer
    @most_reviewed_venue = Venue.most_reviewed_venue
    @best_rated_venue = Venue.best_rated_venue
  end
  def about
  end
  def profile
    @user = User.find(params[:id])
    @user_venues = Venue.where(user_id: @user.id)
  end
end
