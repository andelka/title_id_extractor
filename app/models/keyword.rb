class Keyword < ApplicationRecord
  has_many :items
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
    search_results["@count"].to_i
  end

  def items
    search_results["item"]
  end

  def item_id
    items["itemId"]
  end

  def item_title
    items["title"]
  end

  def cat_id
    items["primaryCategory"]["categoryId"]
  end

  def rebay_shop
    @rs ||= Rebay::Shopping.new
  end

  def cat_results
    rebay_shop.get_category_info({CategoryID: cat_id}).results
  end

  def cat_id_path
    cat_results["CategoryIDPath"]
  end

  def cat_name_path
    cat_results["CategoryNamePath"]
  end

end
