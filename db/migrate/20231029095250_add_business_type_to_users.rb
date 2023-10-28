class AddBusinessTypeToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :business_type, :string
  end
end
