# frozen_string_literal: true

class AddUserIdToQuestions < ActiveRecord::Migration[7.1]
  def change
    add_reference :questions, :user, null: false, foreign_key: true, default: nil
  end
end
