class AddInfToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :isbn, :string
    add_column :books, :publish_date, :datetime
    add_column :books, :publisher, :string
    add_column :books, :picture, :string
  end
end
