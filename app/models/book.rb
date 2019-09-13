class Book < ActiveRecord::Base
    has_many :reviews
    has_many :book_managers
    has_many :users, through: :book_managers
end