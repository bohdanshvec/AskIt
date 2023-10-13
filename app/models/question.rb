class Question < ApplicationRecord
  has_many :answers, dependent: :destroy

  validates :title, presence: true, length: {minimum: 2}
  validates :body, presence: true, length: {minimum: 2}

  scope :ordered, -> { order(id: :desc) }

  def formatted_created_at
    created_at.strftime("%Y-%m-%d %H:%M:%S")
  end

end
