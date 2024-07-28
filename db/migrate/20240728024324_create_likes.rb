class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.bigint :user_id, null: false, foreign_key: true
      t.bigint :post_id, null: false, foreign_key: true
  
      t.timestamps
    end
    
    add_index :likes, [:user_id, :post_id], unique: true
  end
end
