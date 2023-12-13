# frozen_string_literal: true

class Comment < ApplicationRecord
  include Authorship
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :body, presence: true, length: { minimum: 2 }

  def for?(commentable)
    commentable = commentable.object if commentable.decorated?
    commentable == self.commentable
  end
end
