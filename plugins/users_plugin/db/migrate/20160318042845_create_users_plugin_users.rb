class CreateUsersPluginUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users_plugin_users do |t|
      t.string :name
      t.string :email
      t.text :metadata
      t.text :password

      t.timestamps
    end
  end
end
