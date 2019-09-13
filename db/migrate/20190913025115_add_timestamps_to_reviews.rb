class AddTimestampsToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :created_at, :timestamp
    add_column :reviews, :updated_at, :timestamp
  end
end
