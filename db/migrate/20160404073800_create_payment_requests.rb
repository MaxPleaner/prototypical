class CreatePaymentRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :payment_requests do |t|
      t.integer :user_id
      t.integer :from_user_id
      t.integer :length
      t.boolean :accepted, default: false
      t.boolean :paid, default: false

      t.timestamps
    end
  end
end
