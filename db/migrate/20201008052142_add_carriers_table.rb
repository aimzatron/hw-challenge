class AddCarriersTable < ActiveRecord::Migration[5.1]
  def change
    create_table(:carriers) do |t|
      t.string :name, null: false
      t.references :address, foreign_key: true, null: false
      t.bigint :external_id
      t.timestamps

      t.index :name
      t.index :external_id
    end
  end
end
