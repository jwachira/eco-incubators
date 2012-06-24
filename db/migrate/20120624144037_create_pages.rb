class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string  :title
      t.string  :short_description
      t.string  :long_description
      t.boolean :active
      t.boolean :is_product
      t.integer :quantity
      t.float   :price
      t.timestamps
    end
    add_index :pages, :title
  end
end
