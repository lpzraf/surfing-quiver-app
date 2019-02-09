class SessionsController < ApplicationController

  get '/signup' do
    erb :'sessions/signup'
  end

  post '/surfboard_owners' do
    @surfboard_owner = SurfboardOwners.new(params)
    if @surfboard_owner.save
      session[:surfboard_owner_id] = @surfboard_owner.id

      redirect "/surfboard_owners/#{@surfboard_owner.id}"
    else
      flash[:errors] = "Wipe Out! Account creation failure: #{@surfboard_owner.errors.full_messages.to_sentence}"
      redirect '/signup'
    end
  end

  get '/login' do
  	erb :'sessions/login'
  end

  post '/login' do
  	@surfboard_owner = SurfboardOwners.find_by(email: params[:email])

  	if @surfboard_owner && @surfboard_owner.authenticate(params[:password])
  		session[:surfboard_owner_id] = @surfboard_owner.id

  		redirect "surfboard_owners/#{@surfboard_owner.id}"
  	else
      flash[:errors] = "Something's wrong. Your email or password is incorrect. Try again or Sign Up to continue"
      redirect "/login"
  	end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
end
