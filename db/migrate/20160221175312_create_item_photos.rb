class CreateItemPhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :item_photos do |t|
      t.references :item, foreign_key: true
      t.string :filename

      t.timestamps
    end
  end
end
