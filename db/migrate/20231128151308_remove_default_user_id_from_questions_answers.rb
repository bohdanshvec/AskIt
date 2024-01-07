# frozen_string_literal: true

class RemoveDefaultUserIdFromQuestionsAnswers < ActiveRecord::Migration[7.1]
  def up
    change_column_default :questions, :user_id, from: nil, to: nil
    change_column_default :answers, :user_id, from: nil, to: nil
  end

  def down
    change_column_default :questions, :user_id, from: nil, to: nil
    change_column_default :answers, :user_id, from: nil, to: nil
  end
end
