class UpdateForeignKeyOnQuestionsForUsers < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key "questions", "users"
    add_foreign_key "questions", "users", on_delete: :cascade
  end
end
