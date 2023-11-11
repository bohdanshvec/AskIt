# frozen_string_literal: true

class Answer < ApplicationRecord
  include Valid

  belongs_to :question

  validates :body, presence: true, length: { minimum: 5 }
end
