class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :book_title
      t.integer :author_id
      t.integer :published_year

      t.timestamps

    end
  end
end
