class WebsocketMessage
  attr_reader :msg, :published_class
  def initialize(options={})
    @msg, @published_class = options.values_at(:msg, :published_class)
    raise ArgumentError unless [msg, published_class].all?
  end
  def attributes
    {
      'msg' => msg.content_string,
      'id' => msg.id,
      'sender_name' => msg.from_user.name
    }
  end
end