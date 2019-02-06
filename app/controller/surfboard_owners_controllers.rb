class SurfboardOwners < ApplicationController

  get "/surfboard_owners" do
      @surfboard_owners = SurfboardOwner.all

      erb :"surfboard-owners/index"
  end

  get "/surfboard_owners/:id" do
    redirect_if_not_logged_in
    @surfboard_owner = SurfboardOwner.find_by(id: params[:id])

    erb :"surfboard_owners/show"
  end

end
