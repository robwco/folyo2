class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.string :message
      t.references :user, index: true
      t.string :portfolio_message
      t.references :project, index: true

      t.timestamps
    end
  end
end
