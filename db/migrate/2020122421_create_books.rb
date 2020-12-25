class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :name
      t.string :author
      t.text :description
      t.text :house
      t.text :isbn
      t.text :pages
      t.text :circulation
      t.text :size
      t.text :language
      t.text :image
      t.timestamps
      t.index :name
    end
  end
end
