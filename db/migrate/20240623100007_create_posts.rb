class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.text :body, null: false
      t.bigint :user_id, null: false
      t.timestamps
    end

    add_foreign_key :posts, :users
  end
end
