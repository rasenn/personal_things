class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :isbn10, :unique
      t.string :isbn13, :unique
      t.string :name
      t.text :amazon_url, :unique
      t.text :amazon_img
      
      t.timestamps
    end
  end
end
