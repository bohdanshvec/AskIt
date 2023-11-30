# frozen_string_literal: true

module QuestionsAnswers
  extend ActiveSupport::Concern

  included do
    def load_question_answers(do_render: false)
      @question = @question.decorate
      # @question.comments.includes(:user) # для Bullet добавляет в запрос юзеров для коментариев
      @answer ||= @question.answers.build
      @pagy, @answers = pagy(@question.answers.includes(:user).ordered)
      @answers = @answers.decorate
      render 'questions/show', status: :unprocessable_entity if do_render
    end
  end
end
