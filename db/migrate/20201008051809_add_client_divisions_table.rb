class AddClientDivisionsTable < ActiveRecord::Migration[5.1]
  def change
    create_table(:client_divisions) do |t|
      t.string :name
      t.timestamps

      t.index :name
    end
  end
end
