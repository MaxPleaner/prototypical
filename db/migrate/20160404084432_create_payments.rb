class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.references :payment_request, foreign_key: true

      t.timestamps
    end
  end
end
