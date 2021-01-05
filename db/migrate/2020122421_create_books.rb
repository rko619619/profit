class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :name, null: false
      t.string :author, null: false
      t.text :description, null: false
      t.text :house
      t.text :isbn
      t.text :pages
      t.text :circulation
      t.text :size
      t.text :language
      t.text :image
      t.index [:name, :author], unique: true
    end
  end
end
