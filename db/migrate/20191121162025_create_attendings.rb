class CreateAttendings < ActiveRecord::Migration[6.0]
  def change
    create_table :attendings do |t|
      t.references :event
      t.references :user
      t.integer :status
      t.timestamps
    end
  end
end
