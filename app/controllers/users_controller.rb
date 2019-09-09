require './config/environment'

class UsersController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views/users'
    enable :sessions
    set :session_secret, ENV["SESSION_SECRET"]
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/users/#{user.id}"
    end
      redirect '/failure'
  end

  get '/failure' do
    erb :failure
  end

  get '/register' do
    erb :new
  end
  
  post '/register' do
    user = User.new(params)
    if user.save
      redirect "/users/#{@user.id}"
    end
      redirect "/"
    end

  get "/users/:id" do
    @user = User.find_by(:id => params[:id])
    erb :feed
  end

  get "/users/:id/profile" do
    @user = User.find_by(:id => params[:id])
    erb :profile
  end

  post '/logout' do
    session.clear
    redirect '/'
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end 
end