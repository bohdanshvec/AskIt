# frozen_string_literal: true

class Question < ApplicationRecord
  include Authorship
  include Valid
  include Commentable

  has_many :answers, dependent: :destroy

  has_many :question_tags, dependent: :destroy
  has_many :tags, through: :question_tags

  belongs_to :user

  validates :title, presence: true, length: { minimum: 2 }
  validates :body, presence: true, length: { minimum: 2 }

  scope :all_by_tags, lambda { |tags|
    questions = includes(:user)
    questions = if tags
                  questions.joins(:tags).where(tags:).preload(:tags)
                else
                  questions.includes(:question_tags, :tags)
                end

    questions.ordered
  }
end
