class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :title
      t.string :content
      t.integer :rating
      t.integer :user_id
      t.integer :book_id
    end
  end
end
