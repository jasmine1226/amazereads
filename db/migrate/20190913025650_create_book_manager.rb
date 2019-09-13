class CreateBookManager < ActiveRecord::Migration
  def change
    create_table :book_managers do |t|
      t.integer :user_id
      t.integer :book_id
      t.boolean :favorited?, default: false, null: false
      t.boolean :reading?, default: false, null: false
      t.integer :progress
      t.boolean :finished?, default: false, null: false
    end
  end
end
