class CreateSessionTokens < ActiveRecord::Migration
  def change
    create_table :session_tokens do |t|
      t.integer :user_id, null: false
      t.string :session_token, null: false
      t.string :browser
      t.inet :ip_address, null: false
      t.string :device

      t.timestamps null: false
    end

    add_index :session_tokens, [:user_id, :session_token]
  end
end
