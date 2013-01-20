class AddHasSomeone < ActiveRecord::Migration
  def up
    add_column :books, :has_someone, :boolean, :default => true
  end

  def down
  end
end
