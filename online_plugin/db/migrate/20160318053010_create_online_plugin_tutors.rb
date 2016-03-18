class CreateOnlinePluginTutors < ActiveRecord::Migration[5.0]
  def change
    create_table :online_plugin_tutors do |t|
      t.references :user, foreign_key: true
      t.text :metadata

      t.timestamps
    end
  end
end
