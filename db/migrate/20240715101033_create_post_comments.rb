class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|
      t.text :comment
      t.bigint :user_id, null: false
      t.bigint :post_id, null: false

      t.timestamps
    end
    
    add_index :post_comments, :user_id
    add_index :post_comments, :post_id
  end
end
