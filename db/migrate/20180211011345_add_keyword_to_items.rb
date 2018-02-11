class AddKeywordToItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :items, :keyword, foreign_key: true
  end
end
