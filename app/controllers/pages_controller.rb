class PagesController < ApplicationController
  def index
    @best_reviewer = User.best_reviewer
  end
  def about
  end

  def profile
    @user = current_user
    @user_venues = Venue.where(user_id: @user.id)
  end
end
