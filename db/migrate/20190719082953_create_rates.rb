class CreateRates < ActiveRecord::Migration[5.2]
  def change
    create_table :rates do |t|
      t.float :score

      t.timestamps null: false
    end
  end
end
