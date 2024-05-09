class AddDefaultAvatarUsers < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :avatar_url, :string, default: 'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg'
  end
end
