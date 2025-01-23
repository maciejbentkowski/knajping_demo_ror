class AnswersController < ApplicationController
    before_action :authenticate_user!, only: [ :create, :destroy ]

    def create
        @question = Question.find(params[:question_id])
        @venue = @question.venue
        @answer = @question.answers.create(answer_params.merge(user_id: current_user.id))
        redirect_to venue_path(@venue)
    end


    def destroy
        @answer = Answer.find(params[:id])
        @question = @answer.question
        @venue = @question.venue
        if @answer.user == current_user
            @answer.destroy
            redirect_to venue_path(@venue)
        else
            redirect_to venue_path(@venue), alert: "You can't delete this comment"
        end
    end

    private

    def answer_params
        params.require(:answer).permit(:content, :question_id, :user_id)
    end
end
