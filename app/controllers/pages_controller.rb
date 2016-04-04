class PagesController < ApplicationController
  
  def main
  end

  def pay
    byebug
    if @current_user
      _payment_request = PaymentRequest.find_by(id: params[:id])
      if _payment_request
        if _payment_request.from_user.is_user?(@current_user)
          @result = Braintree::Transaction.sale(
            amount: _payment_request.user.price_for(_payment_request.length),
            payment_method_nonce: params[:payment_method_nonce]
          )
          if @result.success?
            _payment_request.update(paid: true)
            message = Message.create(
              content: "paid for #{_payment_request.length} minutes",
              user_id: _payment_request.user.id,
              from_user_id: @current_user.id
            )
            send_msg_to(_payment_request.user, message)
            redirect_to "/user/#{_payment_request.user.id}"
          else
            flash[:messages] << "There was an error with Braintree payment"
            redirect_to "/"
          end
        else
          flash[:messages] << "invalid credentials"
          redirect_to "/"
        end
      else
        flash[:messages] << "payment request not found"
        redirect_to "/"
      end
    else
      flash[:messages] << "please log in again"
      redirect_to "/"
    end
  end

  def accept_payment_request
    if @current_user
      _payment_request = PaymentRequest.find_by(id: params[:id])
      if _payment_request
        if _payment_request.user.is_user?(@current_user)
          _payment_request.update(accepted: true)
          message = Message.create(
            content: "payment request for #{_payment_request.length} minutes was accepted",
            user_id: _payment_request.from_user.id,
            from_user_id: @current_user.id
          )
          send_msg_to(_payment_request.from_user, message)
          redirect_to "/user/#{_payment_request.from_user.id}"
        else
          flash[:messages] << "invalid credentials"
          redirect_to "/"
        end
      else
        flash[:messages] << "payment request not found"
        redirect_to "/"
      end
    else
      flash[:messages] << "please log in again"
      redirect_to "/"
    end
  end

  def decline_payment_request
    if @current_user
      _payment_request = PaymentRequest.find_by(id: params[:id])
      if _payment_request
        if _payment_request.user.is_user?(@current_user)
          message = Message.create(
            content: "payment request for #{_payment_request.length} minutes was declined",
            user_id: _payment_request.from_user.id,
            from_user_id: @current_user.id
          )
          send_msg_to(_payment_request.from_user, message)
          redirect_url = "/user/#{_payment_request.from_user.id}"
          _payment_request.delete
          redirect_to redirect_url
        else
          flash[:messages] << "invalid credentials"
          redirect_to "/"
        end
      else
        flash[:messages] << "payment request not found"
        redirect_to "/"
      end
    else
      flash[:messages] << "please log in again"
      redirect_to "/"
    end    
  end

  def payment_request
    if @current_user
      user = User.find_by(id: params[:id])
      if user && params[:length]
        _payment_request = PaymentRequest.create(user_id: user.id, from_user_id: @current_user.id, length: params[:length])
        message = Message.create(
          content: "new payment request: #{params[:length]} minutes",
          user_id: user.id,
          from_user_id: @current_user.id
        )
        send_msg_to(user, message)
        redirect_to "/user/#{user.id}"        
      else
        flash[:messages] << "failed to send request: user not found"
        redirect_to "/"
      end
    else
      flash[:messages] << "Please log in again"
      redirect_to "/"
    end
  end

  def clear_all
    if @current_user
      @current_user.messages.where(viewed: false).update_all(viewed: true)
      flash[:messages] << "cleared alerts"
      if !params[:user_id].blank?
        redirect_to "/user/#{params[:user_id]}"
      else
        redirect_to "/"
      end
    else
      flash[:messages] << "Please log in again"
      redirect_to "/"
    end
  end

  def message
    message = Message.find_by(id: params[:id])
    if message
      if message.user.eql?(@current_user)
        message.update(viewed: true)
        flash[:messages] << "marked message as viewed"
        redirect_to "/user?id=#{message.from_user.id}"
      else
        flash[:messages] << "not permitted to view that message"
        redirect_to "/"
      end
    else
      flash[:messages] << "message not found"
      redirect_to "/"
    end
  end

  def new_message
    if @current_user
      to_user = User.find_by(id: params[:id])
      if to_user
        message = Message.create(
          content: params[:content],
          user_id: to_user.id,
          from_user_id: @current_user.id
        )
        send_msg_to(to_user, message)
        redirect_to "/user/#{to_user.id}"
      else
        flash[:messages] << "user not found; can't send message to them"
        redirect_to "/"
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
    if (user = User.find_by(email: params[:email])) && user.is_user?(@current_user) &&\
                                                 user.password_is?(params[:password])
        user.update(user_params)
        flash[:messages] << "updated user"
    elsif user
      flash[:messages] << "cant update, invalid password given"
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
    redirect_to "/"
  end

  def logout
    @current_user && logout!(@current_user)
    websocket_response(@current_user, "destroy")
    redirect_to "/"
  end

  def login
    user = User.find_by(email: params[:email])
    if user && user.password_is?(params[:password])
      login!(user)
      websocket_response(user, "create")
    else
      flash[:messages] << "invalid credentials"
    end
    redirect_to "/"
  end

  private
    def user_params
      params.permit(:name, :email, :password, :five_minute_cost, :fifteen_minute_cost, :thirty_minute_cost, :sixty_minute_cost, :skills)
    end

end
