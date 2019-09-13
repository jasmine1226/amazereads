class User < ActiveRecord::Base
    validates_presence_of :username, :email, :password
    validates_uniqueness_of :username, :email
    has_secure_password
    has_many :reviews    
    has_many :book_managers
    has_many :books, through: :book_managers
end