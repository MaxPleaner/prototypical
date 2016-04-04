class PaymentRequest < ApplicationRecord
  
  belongs_to(
    :user,
    foreign_key: :user_id,
    class_name: "User",
    primary_key: :id
  )

  belongs_to(
    :from_user,
    foreign_key: :from_user_id,
    class_name: "User",
    primary_key: :id
  )

end
