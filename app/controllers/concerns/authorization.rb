# frozen_string_literal: true

module Authorization
  extend ActiveSupport::Concern

  included do
    include Pundit::Authorization

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    # rescue_from NoMethodError, with: :handle_no_method_error

    private

    def user_not_authorized
      flash[:danger] = t('global.flash.not_authorized')
      redirect_to(request.referer || root_path) # вернёт на прежнюю страницу или на главную
    end

    # def handle_no_method_error
    #   flash[:danger] = 'Incorrectly filled out form'
    #   redirect_to(request.referer || root_path) # вернёт на прежнюю страницу или на главную
    # end
  end
end
