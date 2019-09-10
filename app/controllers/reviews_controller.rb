class ReviewsController < ApplicationController

    get "/books/:id/reviews/new" do
        if logged_in?
            @book = Book.find_by_id(params[:id])
            erb :'reviews/new'
        else
            redirect '/error'
        end
    end
                
    post "/books/:id/reviews/new" do
        @review = Review.create(rating: params[:rating], content: params[:content])
        @book = Book.find_by_id(params[:id])
        @user = User.find_by_id(session[:user_id])
        @book.reviews.push(@review)
        @user.reviews.push(@review)
        redirect "/reviews/#{@review.id}"
    end

    get "/reviews/:id/edit" do
        @review = Review.find_by_id(params[:id])
        if logged_in? && session[:user_id] == @review.user_id
            @book = Book.find_by_id(@review.book_id)
            erb :'/reviews/edit'
        else
            redirect '/error'
        end
    end

    patch "/reviews/:id/edit" do
        @review = Review.find_by_id(params[:id])        
        @review.content = params[:content]
        @review.rating = params[:rating]
        @review.save
        redirect "/reviews/#{@review.id}"            
    end

    get "/books/:id/reviews" do
        @book = Book.find_by_id(params[:id])
        @reviews = @book.reviews
        erb :'reviews/index_by_book'
    end
  
    get "/users/:id/reviews" do
        @user = User.find_by_id(params[:id])
        @reviews = @user.reviews
        erb :'reviews/index_by_user'
    end

    get "/reviews/:id" do
        @review = Review.find_by(:id => params[:id])
        @book = Book.find_by_id(@review[:book_id])
        erb :'/reviews/show'
    end
  
    delete "/reviews/:id/delete" do
        @review = Review.find_by(:id => params[:id])
        if logged_in? && session[:user_id] == @review.user_id
            @book = Book.find_by_id(@review[:book_id])
            @review.destroy
            redirect "/books/#{@book.id}/reviews"
        else
            redirect '/error'
        end
    end
  end