class PagesController < ApplicationController
  def main
  end
  def ping
    user = User.find_by(id: params[:id])
    user && User.update(last_ping_at: Time.now.to_i)
    head :no_content
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
      if user.persisted?
        login!(user)
        flash[:messages] << "created & logged in"
      else
        flash[:messages] << user.errors.full_messages.join
      end
    end
    redirect_to :back
  end
  def logout
    @current_user && logout!(@current_user)
    redirect_to :back
  end
  def login
    user = User.find_by(email: params[:email])
    if user && user.password_is?(params[:password])
      login!(user)
    else
      flash[:messages] << "invalid credentials"
    end
    redirect_to :back
  end
  private
    def user_params
      params.permit(:name, :email, :password)
    end
end
