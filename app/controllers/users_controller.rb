class UsersController < ApplicationController

  get '/users/new' do
    erb :'/users/new'
  end

  post '/users/new' do
    user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    if user.save
      redirect "/login"
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
      redirect '/error'
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

  delete "/users/:id/delete" do
    User.find_by(:id => params[:id]).destroy
    redirect '/logout'
  end
  
end