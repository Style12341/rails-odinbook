class DeleteAcceptedBlockedColumnsFollows < ActiveRecord::Migration[7.1]
  def change
    remove_column :follows, :accepted, :boolean
    remove_column :follows, :blocked, :boolean
  end
end
