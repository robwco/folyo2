class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :subject
      t.text :message

      t.timestamps
    end
  end
end
