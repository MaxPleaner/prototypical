class PagesController < ApplicationController
  def main
  end

  def new_message
    if @current_user
      to_user = User.find_by(id: params[:user_id])
      if to_user
        Message.create(
          content: params[:content],
          user_id: to_user.id,
          from_user_id: @current_user.id
        )
        send_msg_to(to_user, params[:content])
        redirect_to :back
      else
        flash[:messages] << "user not found; can't send message to them"
        redirect_to :back
      end
    else
      flash[:messages] << "Please log in again"
      redirect_to "/"
    end
  end

  def user
    if @current_user
      @user = User.find_by(id: params[:id])
    else
      flash[:messages] << "Please log in again"
      redirect_to "/"
    end
  end

  def force_logout
    if params[:password].eql?(ForceLogoutPassword)
      ids = params[:ids].split(",")
      ids.each do |id|
        user = User.find_by(id: id)
        if user
          websocket_response(user, "destroy")
        end
      end
    end
    head :no_content
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
        websocket_response(user, "create")
        flash[:messages] << "created & logged in"
      else
        flash[:messages] << user.errors.full_messages.join
      end
    end
    redirect_to :back
  end

  def logout
    @current_user && logout!(@current_user)
    websocket_response(@current_user, "destroy")
    redirect_to :back
  end

  def login
    user = User.find_by(email: params[:email])
    if user && user.password_is?(params[:password])
      login!(user)
      websocket_response(user, "create")
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
