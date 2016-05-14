class AddAttachmentPortfolioImageToReplies < ActiveRecord::Migration
  def self.up
    change_table :replies do |t|
      t.attachment :portfolio_image
    end
  end

  def self.down
    remove_attachment :replies, :portfolio_image
  end
end
