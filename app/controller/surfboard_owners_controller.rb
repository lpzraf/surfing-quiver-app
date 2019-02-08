class SurfboardOwnersController < ApplicationController

  get "/surfboard-owners" do
      @surfboard_owners = SurfboardOwner.all

      erb :"surfboard-owners/index"
  end

  get "/surfboard-owners/:id" do
    redirect_if_not_logged_in
    @surfboard_owner = SurfboardOwner.find_by(id: params[:id])

    erb :"surfboard-owners/show"
  end

end
