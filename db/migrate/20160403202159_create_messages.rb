class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :from_user_id
      t.text :content
      t.boolean :viewed, default: false

      t.timestamps
    end
  end
end
