# frozen_string_literal: true

module Valid
  extend ActiveSupport::Concern

  included do
    scope :ordered, -> { order(id: :desc) }

    def formatted_created_at
      created_at.strftime('%Y-%m-%d %H:%M:%S')
    end
  end
end
