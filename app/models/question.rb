# frozen_string_literal: true

class Question < ApplicationRecord
  include Valid
  include Commentable

  has_many :answers, dependent: :destroy

  belongs_to :user

  validates :title, presence: true, length: { minimum: 2 }
  validates :body, presence: true, length: { minimum: 2 }
end
