class AnswersController < ApplicationController
  before_action :set_question!

  def destroy
    @answer = @question.answers.find params[:id]
    @answer.delete
    redirect_to questions_path(@question)
  end

  def create
    @answer = @question.answers.build answer_params
    if @answer.save
      redirect_to questions_path(@question)
    else
      render 'questions/show'
    end
  end

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_question!
    @question = Question.find params[:question_id]
  end
end