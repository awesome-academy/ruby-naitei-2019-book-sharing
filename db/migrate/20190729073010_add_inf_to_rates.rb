class AddInfToRates < ActiveRecord::Migration[5.2]
  def change
    add_column :rates, :user_id, :integer
    add_column :rates, :book_id, :integer
  end
end
