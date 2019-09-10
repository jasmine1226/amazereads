class UsersController < ApplicationController

  get '/register' do
    erb :'/users/new'
  end

  post '/register' do
    user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    if user.save
      redirect "/users/#{user.id}"
    end
    erb :'/users/failure'
  end

  get "/users/:id" do
    @user = User.find_by(:id => params[:id])
    erb :'/users/profile'
  end

  get "/users/:id/edit" do  
    if logged_in? && current_user.id == params[:id].to_i
        @user = User.find_by(:id => params[:id])
        erb :'/users/edit'
    else
      erb :'/users/error'
    end
  end

  patch "/users/:id/edit" do
    @user = User.find_by(:id => params[:id])
    @user.username = params[:username]
    @user.email = params[:email]
    @user.password = params[:password]
    @user.save
    erb :'/users/profile'
  end

end