class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.string :title, null: false, default: ""
      #記述内容
      t.text :discription, null: false
      t.timestamps
    end
  end
end
