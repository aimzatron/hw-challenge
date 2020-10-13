class AddPolicyTypesTable < ActiveRecord::Migration[5.1]
  def change
    create_table(:policy_types) do |t|
      t.string :name
      t.timestamps

      t.index :name
    end
  end
end
