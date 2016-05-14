class AddOfferDescriptionToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :offer_description, :string
  end
end
