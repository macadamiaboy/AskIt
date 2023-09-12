# frozen_string_literal: true
class QuestionsController < ApplicationController

  before_action :set_question!, only: %i[show destroy edit update]

  def show
    @answer = @question.answers.build
    @answers = @question.answers.order created_at: :desc
  end

  def destroy
    @question.answers.each do |current|
      current.delete
    end
    @question.delete
    redirect_to questions_path
  end

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def update
    if @question.update question_params
      redirect_to questions_path
    else
      render :edit
    end
  end

  def create
    @question = Question.new question_params
    if @question.save
      redirect_to questions_path
    else
      render :new
    end
  end

  private
  def question_params
    params.require(:question).permit(:title, :body)
  end

  def set_question!
    @question = Question.find params[:id]
  end
end
