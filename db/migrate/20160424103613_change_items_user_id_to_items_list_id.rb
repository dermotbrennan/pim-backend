class ChangeItemsUserIdToItemsListId < ActiveRecord::Migration[5.0]
  def change
    rename_column :items, :user_id, :list_id
  end
end
