class CreateTribunals < ActiveRecord::Migration
  def change
    create_table :tribunals do |t|
      t.string :name
      t.references :state, index: true

      t.timestamps null: false
    end
    add_foreign_key :tribunals, :states
  end
end
