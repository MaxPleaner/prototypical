script = <<-RB
  users = User.where("session_token IS NOT NULL")
              .where("last_ping_at IS NOT NULL")
              .where("last_ping_at < ?", Time.now.to_i - 10)
  users.each { |user| user.update(session_token: nil) }
RB
ticker = Ticker.find_or_create_by(
  name: "user_pings",
  content: script,
  interval: 10000 # 10 seconds
)
unless ticker.process_name
  ticker.begin
end