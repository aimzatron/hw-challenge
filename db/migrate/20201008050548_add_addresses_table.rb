class AddAddressesTable < ActiveRecord::Migration[5.1]
  def change
    create_table(:addresses) do |t|
      t.string :address1, null: false
      t.string :address2
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip
      t.timestamps

    end
  end
end
