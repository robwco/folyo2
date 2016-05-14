class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :message
      t.references :user, index: true
      t.references :reply, index: true
      t.references :project, index: true

      t.timestamps
    end
  end
end
