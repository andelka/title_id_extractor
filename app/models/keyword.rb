class Keyword < ApplicationRecord
  validates :text, presence: true

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Keyword.create!(row.to_hash)
    end
  end

  def rebay_find
    @rf ||= Rebay::Finding.new
  end

  def search_results
    rebay_find.find_items_by_keywords({keywords: text}).response["searchResult"]
  end

  def result_count
    self.search_results["@count"].to_i
  end

  def item
    self.search_results["item"]
  end

  def item_id
    self.item["itemId"]
  end

  def item_title
      self.item["title"]
  end

  def cat_id
      self.item["primaryCategory"]["categoryId"]
  end

  def rebay_shop
    @rs ||= Rebay::Shopping.new
  end

end
