class CreateAllTables < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :password
      t.string :email
    end

    create_table :links do |t|
      t.string :url
      t.string :title
      t.string :category
      t.string :short_desc
    end

    create_table :user_links do |t|
      t.integer :user_id
      t.integer :link_id
      t.boolean :visited
      t.boolean :is_favorite
    end
  end
end
