class Conversation
  attr_reader :messages, :other_user
  def initialize(options={})
    @messages, @other_user = options.values_at(:messages, :other_user)
    raise ArgumentError unless [@messages, @other_user].all?
  end
end