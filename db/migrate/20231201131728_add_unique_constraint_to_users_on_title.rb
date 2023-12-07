class AddUniqueConstraintToUsersOnTitle < ActiveRecord::Migration[7.1]
  def change
    add_index :tags, :title, unique: true
  end
end
