class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.datetime :datetime
      t.datetime :until

      t.timestamps
    end
  end
end
