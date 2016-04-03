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

  def messages_with(other_user)
    results = []
    [messages, sent_messages].each do |query|
      results << query.where(from_user_id: other_user.id)
                      .or(query.where(user_id: other_user.id))
                      .order(created_at: :desc).to_a
    end
    results.flatten.sort_by { |msg| msg.created_at }
  end

  def conversations
    other_user_ids = [messages, sent_messages].map do |query|
      query.pluck(:user_id, :from_user_id)
    end.map do |array|
      array.reject { |id2| id2.eql?(self.id) }
    end.flatten.reject { |id2| id2.eql?(self.id) }
    other_user_ids.map do |id2|
      other_user = User.find_by(id: id2)
      Conversation.new(
        other_user: other_user,
        messages: self.messages_with(other_user).map(&:content)
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
