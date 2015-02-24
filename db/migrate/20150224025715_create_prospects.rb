class CreateProspects < ActiveRecord::Migration
  def change
    create_table :prospects do |t|
      t.string :name
      t.string :subject
      t.text :message

      t.timestamps
    end
  end
end
