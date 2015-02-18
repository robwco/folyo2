class CreateRfps < ActiveRecord::Migration
  def change
    create_table :rfps do |t|
      t.string :name

      t.timestamps
    end
  end
end
