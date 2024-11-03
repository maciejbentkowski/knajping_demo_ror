class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_review


    def create
        @review = Review.find(params[:review_id])
        @comment = @review.comments.new(comment_params)
        @comment.user = current_user
        @venue = @review.venue
        if @comment.save
            redirect_to venue_review_path(@venue, @review)
        else
            render "reviews/show"
        end
    end

    def destroy
        @comment = Comment.find(params[:id])
        @venue = @comment.review.venue
        @review = @comment.review
        if @comment.user == current_user
            @comment.destroy
            redirect_to venue_review_path(@venue, @comment.review)
        else
            redirect_to venue_review_path(@venue, @comment.review), notice: "You can't delete this comment"
        end
    end

    private

  def set_review
    @review = Review.find(params[:review_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
