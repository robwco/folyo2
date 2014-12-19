class DropClients < ActiveRecord::Migration
  def up
    drop_client :clients
  end

  def down
    create_table :clients do |t|
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
