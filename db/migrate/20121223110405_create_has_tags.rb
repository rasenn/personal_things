class CreateHasTags < ActiveRecord::Migration
  def change
    create_table :has_tags do |t|
      t.integer :book_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
