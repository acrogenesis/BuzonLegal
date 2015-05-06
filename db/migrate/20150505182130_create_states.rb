class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name
      t.boolean :online, default: true
      t.datetime :last_time_online

      t.timestamps null: false
    end
  end
end
