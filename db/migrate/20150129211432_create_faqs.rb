class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faqs do |t|
      t.string :category
      t.string :question
      t.text :answer
      t.text :notes

      t.timestamps
    end
  end
end
