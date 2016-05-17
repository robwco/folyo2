class AddPermissionsFieldsToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :portfolio_replies, :boolean, default: false
    add_column :plans, :leads, :boolean, default: false
    add_column :plans, :unlimited_replies, :boolean, default: false
    add_column :plans, :view_reply_count, :boolean, default: false
  end
end
