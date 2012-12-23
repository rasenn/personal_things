class CreateHasBooks < ActiveRecord::Migration
  def change
    create_table :has_books do |t|
      t.integer :user_id
      t.integer :book_id
      t.boolean :rend_flag

      t.timestamps
    end

    add_index :has_books, [ :user_id, :book_id ], unique: true
  end
end
