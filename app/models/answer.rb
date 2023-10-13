class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true, length: {minimum: 5}

  scope :ordered, -> { order(id: :desc) }

  def formatted_created_at
    created_at.strftime("%Y-%m-%d %H:%M:%S")
  end

end
