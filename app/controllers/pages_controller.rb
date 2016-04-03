class PagesController < ApplicationController
  def main
  end
  def register
    if (user = User.find_by(id: params[:id])) && user.is_user?(@current_user) &&\
                                                 user.password_is?(params[:password])
        user.update(user_params)
        flash[:messages] << "updated user"
    elsif user
      flash[:messages] << "invalid credentials"
    else
      user = User.create(user_params)
      flash[:messages] << user.valid? ? "created & logged in" : user.errors.full_messages.join("<br>")
    end
    redirect_to :back
  end
  def logout
    @current_user && @current_user.logout
    redirect_to :back
  end
  def login
  end
  private
    def user_params
      params.permit(:name, :email, :password)
    end
end
