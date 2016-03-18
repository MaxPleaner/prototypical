class CreateTutorsPluginTutors < ActiveRecord::Migration[5.0]
  def change
    create_table :tutors_plugin_tutors do |t|
      t.integer :user_id
      t.text :metadata
      t.timestamps
    end
  end
end
