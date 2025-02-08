class QuestionsController < ApplicationController
    load_and_authorize_resource

    def create
        @venue = Venue.find(params[:venue_id])
        @question = @venue.questions.create(question_params.merge(user_id: current_user.id))

        if @question.save
            respond_to do |format|
                format.turbo_stream {
                    render turbo_stream: turbo_stream.replace(
                    "questions_section",
                    partial: "questions/questions",
                    locals: { venue: @venue }
                    )
                }
                format.html { redirect_to venue_path(@question.venue) } # fallback
            end
        else
            respond_to do |format|
                format.html { redirect_to venue_path(@venue), alert: "Could not create question" }
            end
        end
    end


    def destroy
        @question = Question.find(params[:id])

        @question.destroy!
        render turbo_stream: turbo_stream.remove(helpers.dom_id(@question))
    end

    private

    def current_ability
        @current_ability ||= QuestionAbility.new(current_user)
    end

    def question_params
        params.require(:question).permit(:question, :user_id)
    end
end
