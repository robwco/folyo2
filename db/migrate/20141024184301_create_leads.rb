class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.string :photo
      t.string :title
      t.string :url
      t.string :name
      t.string :email
      t.string :website
      t.string :twitter
      t.string :linkedin
      t.string :budget
      t.string :notes

      t.timestamps
    end
  end
end
