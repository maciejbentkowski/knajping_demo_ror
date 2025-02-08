class AnswersController < ApplicationController
    load_and_authorize_resource

    def create
        @question = Question.find(params[:question_id])
        @answer = @question.answers.build(answer_params.merge(user: current_user))


        if @answer.save
            respond_to do |format|
                format.turbo_stream {
                    render turbo_stream: turbo_stream.replace(
                    helpers.dom_id(@question),
                    partial: "questions/question",
                    locals: { question: @question }
                    )
                }
                format.html { redirect_to venue_path(@question.venue) } # fallback
            end
        else
            format.html { redirect_to venue_path(@question.venue), alert: "Nie mozesz odpowiedzieć" }
        end
    end


    def edit
        @answer = Answer.find(params[:id])
    end

    def update
        @answer = Answer.find(params[:id])
        @question = @answer.question
        @answer.update(answer_params)

        respond_to do |format|
            format.turbo_stream {
                render turbo_stream: turbo_stream.replace(
                helpers.dom_id(@answer),
                partial: "answers/answer",
                locals: { answer: @answer }
                )
            }
            format.html { redirect_to venue_path(@question.venue) } # fallback
        end
    end

    def destroy
        @answer = Answer.find(params[:id])
        @answer.destroy!

        render turbo_stream: turbo_stream.remove(helpers.dom_id(@answer))
    end

    private
    def current_ability
        @current_ability ||= AnswerAbility.new(current_user)
    end

    def answer_params
        params.require(:answer).permit(:content)
    end
end
