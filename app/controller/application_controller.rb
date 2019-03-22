require "./config/environment"
require 'rack-flash'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash
  configure do
  set :public_folder, "public"
  set :views, "app/views"
  enable :sessions
  set :session_secret, "surfing-quiver-app_secret"
  end

  get "/" do
    if logged_in?
      redirect "/surfboard_owners/#{current_user.id}"
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
      surfboard.surfboard_owner == current_user
    end

    def not_allowed_to_edit(surfboard)
      if surfboard.surfboard_owner != current_user
        flash[:errors] = "You can only edit your surfboards."
        redirect "/surfboard_owners"
      end
    end

    def redirect_if_not_logged_in
      if !logged_in?
        flash[:errors] = "You must be logged in to check this radical page"
        redirect '/'
      end
    end

    def owner_name(surfboard)
      if surfboard.surfboard_owner == current_user
        "your"
      else
        surfboard.surfboard_owner.first_name + "'s"
      end
    end

#new method for patch
    def must_fill_all_fields(surfboard)
  		if surfboard.surfboard_owner != current_user || !form_is_filled?
  			flash[:errors] = "All fields must be filled."
  			redirect "/surfboards/#{@surfboard.id}/edit"
  		end
  	end

#new method for delete
  def destroy_surfboard(surfboard)
      if authorized_to_edit?(surfboard)
        flash[:message] = "Your surfboard was deleted"
        surfboard.destroy
        redirect "/surfboard_owners/#{current_user.id}"
      end
    end
  end
end
