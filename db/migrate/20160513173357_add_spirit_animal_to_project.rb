class AddSpiritAnimalToProject < ActiveRecord::Migration
  def change
	add_column :projects, :spirit_animal, :string
  end
end
