class Message < ApplicationRecord
  include ActionView::Helpers::DateHelper # for time_ago_in_words

  belongs_to :user, class_name: "User", foreign_key: :user_id, primary_key: :id
  belongs_to :from_user, class_name: "User", foreign_key: :from_user_id, primary_key: :id
  def content_string
    "#{content} (#{time_ago_in_words(created_at)} ago)"
  end
end
