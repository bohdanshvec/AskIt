# frozen_string_literal: true

module Valid
  extend ActiveSupport::Concern

  included do
    scope :ordered, -> { order(id: :desc) }

    def formatted_created_at
      I18n.l(created_at, format: :long)
    end
  end
end
