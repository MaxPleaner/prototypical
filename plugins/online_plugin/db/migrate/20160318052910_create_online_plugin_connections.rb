class CreateOnlinePluginConnections < ActiveRecord::Migration[5.0]
  def change
    create_table :online_plugin_connections do |t|
      t.string :category
      t.text :metadata

      t.timestamps
    end
  end
end
