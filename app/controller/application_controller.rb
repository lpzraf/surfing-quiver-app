require "./config/environment"

class ApplicationController < Sinatra::Base
  configure do
  set :public_folder, "public"
  set :views, "app/views"
  enable :sessions
  set :session_secret, "surfing-quiver-app_secret"
  end

  get "/" do
    if logged_in?
      redirect "/surfboard-owners/#{current_user.id}"
    else
      erb :'sessions/welcome'
    end
  end

  helpers do

    def logged_in?
  	  !!current_user
    end

    def current_user
  		@current_surfboard_owner ||= SurfboardOwner.find_by(id: session[:surfboard_owner_id])
    end

    def authorized_to_edit?(surfboard)
      surfboard.SurfboardOwner == current_user
    end

    def redirect_if_not_logged_in
      if !logged_in?
        flash[:errors] = "You must be logged in to check out this radical page"
        redirect '/'
      end
    end
  end
end
