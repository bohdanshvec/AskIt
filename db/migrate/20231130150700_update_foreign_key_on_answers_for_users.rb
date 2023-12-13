# frozen_string_literal: true

class UpdateForeignKeyOnAnswersForUsers < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key 'answers', 'users'
    add_foreign_key 'answers', 'users', on_delete: :cascade
  end
end
