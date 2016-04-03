class CreateTickers < ActiveRecord::Migration[5.0]
  def change
    create_table :tickers do |t|
      t.string :process_name
      t.string :name
      t.text :content
      t.integer :interval

      t.timestamps
    end
  end
end
