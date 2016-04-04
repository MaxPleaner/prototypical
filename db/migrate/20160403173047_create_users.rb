class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.text :password
      t.text :session_token
      t.integer :five_minute_cost
      t.integer :fifteen_minute_cost
      t.integer :thirty_minute_cost
      t.integer :sixty_minute_cost
      t.string :skills
      t.integer :last_ping_at
      t.timestamps
    end
  end
end
