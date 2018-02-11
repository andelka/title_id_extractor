class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :title
      t.string :item_id
      t.string :cat_id

      t.timestamps
    end
  end
end
