class SurfboardOwnersController < ApplicationController

  get "/surfboard_owners" do
      @surfboard_owners = SurfboardOwners.all

      erb :"surfboard_owners/index"
  end

  get "/surfboard_owners/:id" do
    redirect_if_not_logged_in
    @surfboard_owner = SurfboardOwners.find_by(id: params[:id])

    erb :"surfboard_owners/show"
  end

end
