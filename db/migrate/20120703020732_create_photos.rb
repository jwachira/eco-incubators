class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :imageable, :polymorphic => true
      t.string :image
      t.string :title
      t.text :description
      t.timestamps
    end
    add_index :photos, :imageable_id
  end
end
