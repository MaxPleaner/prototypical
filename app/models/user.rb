class User < ApplicationRecord
  def create(*args)
    result = super(*args)
    result.login if result.valid?
    result
  end
  def password=(pwd)
    super(BCrypt::Password.create(pwd))
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
