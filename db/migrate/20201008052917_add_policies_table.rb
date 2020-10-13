class AddPoliciesTable < ActiveRecord::Migration[5.1]
  def change
    create_table(:policies) do |t|
      t.belongs_to :client
      t.belongs_to :carrier
      t.datetime :effective_date, null: false
      t.datetime :expiration_date, null: false
      t.float :written_premium, null: false
      t.bigint :carrier_policy_number, null: false
      t.bigint :external_id
      t.references :policy_division, foreign_key: true, null: false
      t.references :policy_type, foreign_key: true, null: false


      t.timestamps
      t.index :external_id
    end
  end
end
