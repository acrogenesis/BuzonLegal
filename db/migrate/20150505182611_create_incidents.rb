class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.text :description
      t.references :state, index: true
      t.boolean :public

      t.timestamps null: false
    end
    add_foreign_key :incidents, :states
  end
end
