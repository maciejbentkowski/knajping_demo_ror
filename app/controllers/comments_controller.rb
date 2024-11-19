class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_review, only: [:create, :destroy]
    before_action :set_comment, only: :destroy

    def create
        @comment = @review.comments.new(comment_params)
        @comment.user = current_user

        authorize! :create, @comment
        @venue = @review.venue
        if @comment.save
            redirect_to venue_review_path(@venue, @review)
        else
            render "reviews/show"
        end
    end

    def destroy
        authorize! :destroy, @comment

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

    def set_comment
        @comment = Comment.find(params[:id])
    end

    def comment_params
        params.require(:comment).permit(:content)
    end

    def current_ability
        @current_ability ||= CommentAbility.new(current_user)
    end
end
