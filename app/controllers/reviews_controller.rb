class ReviewsController < ApplicationController
    before_action :set_venue
    before_action :set_review, only: [ :edit, :update ]
    before_action :authenticate_user!, except: [ :show ]
    before_action :check_if_user_is_owner, only: [ :new, :create, :edit, :update ]

    def show
        @review = Review.find(params[:id])
        @comment = Comment.new
    end

    def new
        @review = @venue.reviews.find_by(user: current_user)
        if @review
            redirect_to edit_venue_review_path(@venue, @review)
        else
            @review = @venue.reviews.new
            @review.build_rating
        end
    end

    def create
        @review = Review.new(review_params.merge(user_id: current_user.id, venue_id: @venue.id))
        if @review.save
            redirect_to venue_path(@venue)
        else
            render :new
        end
    end

    def edit
        @review.build_rating(@review.rating) unless @review.rating
    end

    def update
        if @review.update(review_params)
          redirect_to @venue, notice: "Review was successfully updated."
        else
          render :edit
        end
      end

    private
    def set_venue
        @venue = Venue.find(params[:venue_id])
    end

    def set_review
        @review = @venue.reviews.find_by(user_id: current_user)
        unless @review
          redirect_to new_venue_review_path(@venue)
        end
      end

    def review_params
        params.require(:review).permit(:title, :content, :user_id, :venue_id, rating_attributes: [ :atmosphere_rating, :availability_rating, :quality_rating, :service_rating, :uniqueness_rating, :value_rating ])
    end

    def check_if_user_is_owner
        unless @venue.user != current_user
          redirect_to venue_path(@venue), alert: "Nie możesz recenzować swojej restauracji"
        end
    end
end
