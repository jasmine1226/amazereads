class ReviewsController < ApplicationController

    get "/reviews/new/:id" do
        if logged_in?
            @book = Book.find_by_id(params[:id])
            erb :'reviews/new'
        else
            redirect '/error'
        end
    end
                
    post "/reviews/new/:id" do
        @review = Review.create(rating: params[:rating], content: params[:content])
        @book = Book.find_by_id(params[:id])
        @user = User.find_by_id(session[:user_id])
        @book.reviews.push(@review)
        @user.reviews.push(@review)
        redirect "/reviews/#{@review.id}"
    end

    get "/reviews/:id/edit" do
        @review = Review.find(params[:id])
        if logged_in? && session[:user_id] == @review.user_id
            @book = Book.find(@review.book_id)
            erb :'/reviews/edit'
        else
            redirect '/error'
        end
    end

    patch "/reviews/:id" do
        @review = Review.find(params[:id])        
        @review.content = params[:content]
        @review.rating = params[:rating]
        @review.save
        redirect "/reviews/#{@review.id}"            
    end

    get "/books/:id/reviews" do
        @book = Book.find(params[:id])
        @reviews = @book.reviews
        erb :'reviews/index_by_book'
    end
  
    get "/users/:id/reviews" do
        @user = User.find(params[:id])
        @reviews = @user.reviews
        erb :'reviews/index_by_user'
    end

    get "/reviews/:id" do
        @review = Review.find(params[:id])
        @book = Book.find(@review.book_id)
        if logged_in?
            @user = User.find(session[:user_id])
        end
        erb :'/reviews/show'
    end
  
    delete "/reviews/:id" do
        @review = Review.find(params[:id])
        if logged_in? && session[:user_id] == @review.user_id
            @book = Book.find_by_id(@review[:book_id])
            @review.destroy
            redirect back
        else
            redirect '/error'
        end
    end
  end