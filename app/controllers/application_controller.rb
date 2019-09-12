class ApplicationController < Sinatra::Base
  register Sinatra::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    @recent_reviews = Review.all.last(3)
    erb :welcome
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else
      redirect '/login_failure'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/registration_failure' do
    flash[:warning] = "Uh-oh! The username or email has been taken. Try a different one."
    redirect back
  end

  get '/login_failure' do
    flash[:warning] = "Uh-oh! Your username or password may be incorrect."
    redirect back
  end

  helpers do
    def logged_in?
       !!current_user
    end
  
    def current_user         
      @current_user = User.find_by(:id => session[:user_id]) if session[:user_id]
    end
  end
end
