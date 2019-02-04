require "./config/environment"
class ApplicationController < Sinatra::Base
configure do
set :public_folder, "public"
set :views, "app/views"
enable :sessions
set :session_secret, "surfing-quiver-app_secret"
end
get '/' do
session[:greeting] = "Hello World!"
"Hello World!"
end
end
