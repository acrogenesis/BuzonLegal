class CreateCases < ActiveRecord::Migration
  def change
    create_table :cases do |t|
      t.datetime :date
      t.string :casenumber
      t.text :description
      t.references :tribunal, index: true

      t.timestamps null: false
    end
    add_foreign_key :cases, :tribunals
  end
end
