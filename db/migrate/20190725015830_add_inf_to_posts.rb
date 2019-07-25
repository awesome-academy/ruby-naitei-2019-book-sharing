class AddInfToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :user_id, :integer
    add_column :posts, :book_id, :integer
    add_column :posts, :title, :string
  end
end
