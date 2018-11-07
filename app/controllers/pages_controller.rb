class PagesController < ApplicationController
  def dashboard
  	@user_all = User.all
  end

  def delete_user
  	user.destroy
  end
end
