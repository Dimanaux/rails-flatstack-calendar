class AddColumnNameToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :name, :string
  end
end
