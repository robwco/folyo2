class AddHasPortfolioToReply < ActiveRecord::Migration
  def change
    add_column :replies, :has_portfolio, :boolean, default: false

    Reply.all.each do |reply|
      if reply.portfolio_message.present?
        reply.has_portfolio = true
        reply.save
      end
    end
  end
end
