class CreateTutorialsPluginTutorials < ActiveRecord::Migration[5.0]
  def change
    create_table :tutorials_plugin_tutorials do |t|
      t.integer :user_id
      t.string :name
      t.text :content
      t.text :metadata

      t.timestamps
    end
  end
end
