class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.bigint :host_id
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.string :google_id
      t.string :location


      t.timestamps
    end
  end
end
