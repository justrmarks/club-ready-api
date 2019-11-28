class AddGoogleLinkToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :google_link, :string
  end
end
