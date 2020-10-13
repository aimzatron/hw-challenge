class AddClientsTable < ActiveRecord::Migration[5.1]
  def change
    create_table(:clients) do |t|
      t.string :name, null: false
      t.references :address, foreign_key: true, null: false
      t.bigint :major_group, null: false
      t.bigint :industry_group, null: false
      t.bigint :sic, null: false
      t.text :description, null: false
      t.references :client_division, foreign_key: true, null: false
      t.bigint :external_id

      t.timestamps

      t.index :name
      t.index :external_id
    end
  end
end
