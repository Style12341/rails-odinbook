class CreateFollows < ActiveRecord::Migration[7.1]
  def change
    create_table :follows do |t|
      t.references :followee, null: false, foreign_key: { to_table: :users }
      t.references :follower, null: false, foreign_key: { to_table: :users }
      t.boolean :blocked, default: false
      t.boolean :accepted, default: false
      t.timestamps
    end
  end
end
