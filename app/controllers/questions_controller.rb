class QuestionsController < ApplicationController
    before_action :authenticate_user!, only: [ :create, :destroy ]

    def create
        @venue = Venue.find(params[:venue_id])
        @question = @venue.questions.create(question_params.merge(user_id: current_user.id))
        redirect_to venue_path(@venue)
    end


    def destroy
        @question = Question.find(params[:id])
        @venue = @question.venue
        if @question.user == current_user
            @question.destroy
            redirect_to venue_path(@venue)
        else
            redirect_to venue_path(@venue), notice: "You can't delete this comment"
        end
    end

    private

    def question_params
        params.require(:question).permit(:question, :user_id)
    end
end
