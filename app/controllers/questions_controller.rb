# frozen_string_literal: true

class QuestionsController < ApplicationController
  # http_basic_authenticate_with name: "dan", password: "password", except: [:index, :show]
  # спрашивает пользователя и пароль при обращении к методу

  before_action :set_question!, only: %i[show edit update destroy]

  def index
    @pagy, @questions = pagy(Question.ordered)
  end

  def show
    @answer = @question.answers.build
    @pagy, @answers = pagy(@question.answers.ordered)
    # @answers = @question.answers.ordered
    # @answers = Answer.where(question: @question).limit(2).order(created_at: :desc)
  end

  def new
    @question = Question.new
  end

  def edit; end

  def create
    @question = Question.new(question_params)

    if @question.save
      flash[:success] = t('.success')
      redirect_to questions_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @question.update(question_params)
      flash[:success] = t('.success')
      redirect_to questions_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @question.delete
    flash[:success] = t('.success')
    redirect_to questions_path, status: :see_other
  end

  private

  def set_question!
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
