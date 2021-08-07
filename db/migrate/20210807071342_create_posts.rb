class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user
      t.string :title, limit: 255, null: false
      t.text :body
      t.timestamps
    end
  end
end
