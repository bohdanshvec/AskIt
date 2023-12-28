# frozen_string_literal: true

class QuestionsController < ApplicationController
  # http_basic_authenticate_with name: "dan", password: "password", except: [:index, :show]
  # спрашивает пользователя и пароль при обращении к методу
  include QuestionsAnswers

  before_action :require_authentication, except: %i[index show]
  before_action :set_question!, only: %i[show edit update destroy]
  before_action :fetch_tags, only: %i[index new create edit]
  before_action :authorize_question!
  after_action :verify_authorized

  def index
    @tags = Tag.where(id: params[:tag_ids]) if params[:tag_ids]
    @pagy, @questions = pagy Question.all_by_tags(@tags), link_extra: 'data-turbo-frame="pagination_pagy"'
    @questions = @questions.decorate
  end

  def show
    load_question_answers(do_render: true)

    # @answers = Answer.where(question: @question).limit(2).order(created_at: :desc)
  end

  def new
    @question = Question.new
  end

  def edit; end

  def create
    @question = current_user.questions.build(question_params)

    if @question.save
      respond_to do |format|
        format.html do
          flash[:success] = t('.success')
          redirect_to questions_path
        end

        format.turbo_stream do
          @question = @question.decorate
          flash.now[:success] = t('.success')
        end
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    # binding.pry
    if @question.update(question_params)
      respond_to do |format|
        format.html do
          flash[:success] = t('.success')
          redirect_to questions_path
        end

        format.turbo_stream do
          @question = @question.decorate
          flash.now[:success] = t('.success')
        end
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @question.delete
    respond_to do |format|
      format.html do
        flash[:success] = t('.success')
        redirect_to questions_path, status: :see_other
      end

      format.turbo_stream { flash[:success] = t('.success') }
    end
  end

  private

  def set_question!
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, tag_ids: [])
  end

  def fetch_tags
    @tags = Tag.all
  end

  def authorize_question!
    authorize(@question || Question)
  end
end
