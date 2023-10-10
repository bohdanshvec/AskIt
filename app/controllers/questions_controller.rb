class QuestionsController < ApplicationController

  def index
    @questions = Question.ordered
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to questions_path
    else
      # byebug
      render :new
    end

  end

  def show
    @question = Question.find_by(id: params[:id])
  end

  def edit
    @question = Question.find_by(id: params[:id])
  end

  def update
    @question = Question.find_by(id: params[:id])
    if @question.update(question_params)
      redirect_to questions_path
    else
      render :edit
    end
  end

  def destroy
    @question = Question.find_by(id: params[:id])
    @question.delete
    redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

end