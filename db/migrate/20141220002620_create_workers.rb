class CreateWorkers < ActiveRecord::Migration
  def change
    create_table :workers do |t|
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
