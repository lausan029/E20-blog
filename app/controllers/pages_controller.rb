class PagesController < ApplicationController
  def dashboard
  	@user_all = User.all
  end

  def delete_user
  	u = User.find(params[:id])
  	u.destroy
  	redirect_to pages_dashboard_path
  end
end
