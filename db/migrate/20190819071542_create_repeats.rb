class CreateRepeats < ActiveRecord::Migration[5.2]
  def change
    create_table :repeats do |t|
      t.references :event, foreign_key: true
      t.datetime :datetime

      t.timestamps
    end
  end
end
