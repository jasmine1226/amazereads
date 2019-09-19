class User < ActiveRecord::Base
    validates_presence_of :username, :email, :password
    validates_uniqueness_of :username, :email
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
    has_secure_password
    has_many :reviews
    has_and_belongs_to_many :books
end