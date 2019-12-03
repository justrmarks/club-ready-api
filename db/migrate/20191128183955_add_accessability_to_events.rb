class AddAccessabilityToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :bathrooms, :integer
    add_column :events, :water, :integer
    add_column :events, :mobility, :integer
    add_column :events, :flashing_lights, :boolean
  end
end
