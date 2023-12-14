# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'admin@AskIt.com'
  layout 'mailer'
end
