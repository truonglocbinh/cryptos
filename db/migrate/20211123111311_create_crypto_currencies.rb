class CreateCryptoCurrencies < ActiveRecord::Migration[6.1]
  def change
    create_table :crypto_currencies do |t|
      t.string :name, null: false
      t.string :short_name
      t.decimal :single_transaction_cost, precision: 15, scale: 10
      t.decimal :multisig_transaction_cost, precision: 15, scale: 10
      t.integer :multiisg_factor
      t.timestamps
    end
  end
end
