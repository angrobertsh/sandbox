class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :post_id
      t.string :subject
      t.string :body, null: false

      t.timestamps
    end
    add_index :comments, [:user_id, :post_id]
  end
end
