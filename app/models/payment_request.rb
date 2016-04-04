class PaymentRequest < ApplicationRecord

  has_one(
    :payment,
    foreign_key: :payment_request_id,
    class_name: "Payment",
    primary_key: :id
  )
  
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
