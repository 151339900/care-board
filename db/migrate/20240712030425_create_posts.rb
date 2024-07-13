class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false, default: ""
      t.integer :post_id, null: false, default: ""
      t.string :title, null: false, default: ""
      #記述内容
      t.text :discription, null: false, default: ""
      t.timestamps
    end
  end
end
