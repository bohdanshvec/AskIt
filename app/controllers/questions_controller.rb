class QuestionsController < ApplicationController

  before_action :set_question!, only: %i[show edit update destroy]

  def index
    @questions = Question.ordered
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      flash[:success] = 'Question created!'
      redirect_to questions_path
    else
      render :new, status: :unprocessable_entity
    end

  end

  def show
    @answer = @question.answers.build
    @answers = Answer.ordered
  end

  def edit
  end

  def update
    if @question.update(question_params)
      flash[:success] = 'Question updated!'
      redirect_to questions_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @question.delete
    flash[:success] = 'Question deleted!'
    redirect_to questions_path
  end

  private

  def set_question!
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end

end
