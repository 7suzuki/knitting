class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.bigint :follower_id, null: false
      t.bigint :followed_id, null: false

      t.timestamps
    end

    add_index :relationships, :follower_id
    add_index :relationships, [:followed_id, :follower_id], unique: true
  end
end
