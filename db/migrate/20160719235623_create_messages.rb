class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :content
      t.bigint :user_id
      t.bigint :conversation_id

      t.timestamps
    end
  end
end
