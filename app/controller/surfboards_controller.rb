require 'sinatra/flash'

class SurfboardsController < ApplicationController

	get '/surfboards/new' do
	  redirect_if_not_logged_in
	  erb :'/surfboards/new'
	end

	post '/surfboards' do
	  redirect_if_not_logged_in
	  if form_is_filled?
	    flash[:message] = "Your surfboard was successfully added to the quiver"
	    @surfboard = Surfboard.create(brand_name: params[:brand_name], shaper: params[:shaper], length: params[:length], width: params[:width], thickness: params[:fthickness], tail: params[:tail], type_of_surf: params[:type_of_surf], surfboard_owner_id: current_user.id)
	    redirect "/surfboards/#{@surfboard.id}"
	  else
	    flash[:errors] = "If you want to add the board to your quiver you have to fill all the empty fields."
	    redirect '/surfboards/new'
	  end
	end

	get '/surfboards/:id'  do
	  redirect_if_not_logged_in
	  set_surfboard
		if @surfboard.nil?
			redirect "/surfboard_owners"
		else
			erb :'/surfboards/show'
		end
	end

	get '/surfboards/:id/edit' do
	  set_surfboard
	  redirect_if_not_logged_in
	  if @surfboard.surfboard_owner == current_user
	  	erb :'/surfboards/edit'
	  else flash[:errors] = "You can only edit your surfboards."
	  redirect "/surfboard_owners"
	  end
	end

	patch '/surfboards/:id' do
	  set_surfboard
	  redirect_if_not_logged_in
	  if @surfboard.surfboard_owner == current_user && form_is_filled?
	  	flash[:message] = "Success! Your surfboard was updated."
	  	@surfboard.update(brand_name: params[:brand_name], shaper: params[:shaper], length: params[:length], width: params[:width], thickness: params[:thickness], tail: params[:tail], type_of_surf: params[:type_of_surf])
	  	redirect "/surfboards/#{@surfboard.id}"
	  else
	  	flash[:errors] = "All fields must be filled."
	  	redirect "/surfboards/#{@surfboard.id}/edit"
	  end
	end

	delete '/surfboards/:id' do
	  set_surfboard
	  if authorized_to_edit?(@surfboard)
	  	flash[:message] = "Your surfboard was deleted"
	    @surfboard.destroy
	    redirect "/surfboard_owners/#{current_user.id}"
	  else
	  	redirect "/surfboard_owners/#{current_user.id}"
	  end
	end


	private

	def set_surfboard
		@surfboard = Surfboard.find(params[:id])
	end

	def form_is_filled?
		params[:brand_name] != "" && params[:shaper] != "" && params[:length] != "" && params[:width] != "" && params[:thickness] != "" && params[:tail] != "" && params[:type_of_surf] != ""
	end
end
