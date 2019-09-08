require './config/environment'

class UsersController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views/users'
  end

  get '/login' do
    erb :feed
  end

end