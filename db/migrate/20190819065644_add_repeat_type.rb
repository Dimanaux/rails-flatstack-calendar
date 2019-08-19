class AddRepeatType < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      CREATE TYPE repeat_type AS ENUM ('once', 'daily', 'weekly', 'monthly', 'annually');
    SQL
    add_column :events, :repeat_type, :repeat_type, null: false, default: 'once'
  end

  def down
    remove_column :events, :repeat_type
    execute <<-SQL
      DROP TYPE repeat_type;
    SQL
  end
end
