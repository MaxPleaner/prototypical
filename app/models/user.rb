class User < ApplicationRecord

  has_many(
    :messages,
    foreign_key: :user_id, 
    class_name: "Message",
    primary_key: :id
  )
  has_many(
    :sent_messages,
    foreign_key: :from_user_id,
    class_name: "Message",
    primary_key: :id
  )

  has_many(
    :payment_requests,
    foreign_key: :user_id,
    class_name: "PaymentRequest",
    primary_key: :id
  )

  has_many(
    :sent_payment_requests,
    foreign_key: :from_user_id,
    class_name: "PaymentRequest",
    primary_key: :id
  )

  def price_for(length)
    raise ArgumentError unless persisted?
    case length.to_i
    when 5
      five_minute_cost
    when 15
      fifteen_minute_cost
    when 30
      thirty_minute_cost
    when 60
      sixty_minute_cost
    else
      nil
    end
  end

  def messages_with(other_user)
    raise ArgumentError unless [self, other_user].all?(&:persisted?)
    results = []
    [messages, sent_messages].each do |query|
      results << query.where(from_user_id: other_user.id)
                      .or(query.where(user_id: other_user.id))
                      .or(query.where(user_id: self.id, from_user_id: self.id))
                      .order(created_at: :desc).to_a
    end
    results.flatten.sort_by { |msg| msg.created_at }
  end

  def conversations
    raise ArgumentError unless persisted?
    other_user_ids = [messages, sent_messages].map do |query|
      query.pluck(:user_id, :from_user_id)
    end.map do |array|
      array.reject { |id2| id2.eql?(self.id) && !(array.all? { |id| id.eql?(self.id) }) }
    end.flatten.uniq
    other_user_ids.map do |id2|
      other_user = User.find_by(id: id2)
      Conversation.new(
        other_user: other_user,
        messages: self.messages_with(other_user)
                      .uniq { |msg| msg.id }
                      .map(&:content)
      )
    end
  end

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
