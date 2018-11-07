class PagesController < ApplicationController
  def dashboard
  	@user_all = User.all.order(:name)
  end

  def edit_user
  	u = User.find(params[:id])
  	if u.admin?
  		u.role = 1
  	else
  		u.role = 0
  	end
  	u.save

  	redirect_to pages_dashboard_path
  end

  def delete_user
  	u = User.find(params[:id])
  	u.destroy
  	redirect_to pages_dashboard_path
  end
end
