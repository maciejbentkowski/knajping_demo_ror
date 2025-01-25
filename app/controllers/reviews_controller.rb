class ReviewsController < ApplicationController
    before_action :authenticate_user!, except: [ :show ]
    before_action :set_venue
    before_action :set_review, only: [ :show, :edit, :update ]
    load_and_authorize_resource


    def show
      @comment = Comment.new
    end

    def new
      # Check if user is the venue owner
      if @venue.user == current_user
        redirect_to venue_path(@venue), alert: "You cannot review your own venue."
        return
      end

      # Check for existing review
      if existing_review = @venue.reviews.find_by(user: current_user)
        redirect_to edit_venue_review_path(@venue, existing_review),
          notice: "You already have a review for this venue. You can edit it instead."
        return
      end

      @review = @venue.reviews.new
      @review.build_rating
      authorize! :new, @review
    end

    def create
      if @venue.user == current_user
        redirect_to venue_path(@venue), alert: "You cannot review your own venue."
        return
      end

      @review = @venue.reviews.build(review_params)
      @review.user = current_user
      authorize! :create, @review

      if @review.save
        redirect_to venue_path(@venue), notice: "Review was successfully created."
      else
        @review.build_rating unless @review.rating
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @review.build_rating unless @review.rating
      rescue CanCan::AccessDenied
        redirect_to venue_path(@venue)
    end

    def update
      # First check if the review exists and belongs to the current user
      unless @review && @review.user == current_user
        redirect_to venue_path(@venue), alert: "You can only edit your own reviews."
        return
      end

      if @review.update(review_params)
        redirect_to venue_path(@venue), notice: "Review was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def current_ability
        @current_ability ||= ::ReviewAbility.new(current_user)
    end

    def set_venue
      @venue = Venue.find(params[:venue_id])
    end

    def set_review
      @review = @venue.reviews.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to venue_path(@venue), alert: "Review not found."
    end

    def review_params
      params.require(:review).permit(
        :title,
        :content,
        rating_attributes: [
          :atmosphere_rating,
          :availability_rating,
          :quality_rating,
          :service_rating,
          :uniqueness_rating,
          :value_rating
        ]
      )
    end
end
