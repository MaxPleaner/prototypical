class User < ApplicationRecord
  def create(*args)
    result = super(*args)
    result.login if result.persisted?
    result
  end
  def password=(pwd)
    super(BCrypt::Password.create(pwd))
  end
  def login
    raise ArgumentError unless persisted?
    update(session_token: SecureRandom.urlsafe_base64)
    session[:current_user_id] = id
  end
  def logout
    raise ArgumentError unless persisted?
    update(session_token: nil)
    session.delete(:current_user_id)
  end
  def is_user?(user)
    raise ArgumentError unless persisted?
    id.eql?(user.try(:id))
  end
  def password_is?(pwd)
    raise ArgumentError unless persisted?
    BCrypt::Password.new(password).is_password?(pwd)
  end
end
