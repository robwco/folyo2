class AddCreditCardToUser < ActiveRecord::Migration
  def change
    add_column :users, :last4, :string
    add_column :users, :expiration_month, :integer
    add_column :users, :expiration_year, :integer
  end
end
