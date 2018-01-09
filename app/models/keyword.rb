class Keyword < ApplicationRecord
  validates :text, presence: true

  # def self.to_csv
  #   CSV.generate do |csv|
  #     csv << ["item_id", "item_title", "category_id", "category_name"]
  #     keywords = self.all
  #     keywords.each do |keyword|
  #       search_results = keyword.get_search_results
  #       result_count = keyword.get_result_count
  #       #parsed_search_results = JSON.parse(search_results.to_json)
  #       if result_count > 1
  #         items = search_results["item"]
  #         items.each do |item|
  #           item_id = item["itemId"]
  #           item_title = item["title"]
  #           category_id = item["primaryCategory"]["categoryId"]
  #           category_name = item["primaryCategory"]["categoryName"]
  #           csv << [item_id, item_title, category_id, category_name]
  #         end
  #       elsif result_count == 1
  #         items = search_results["item"]
  #         item_id = items["itemId"]
  #         item_title = items["title"]
  #         category_id = items["primaryCategory"]["categoryId"]
  #         category_name = items["primaryCategory"]["categoryName"]
  #         csv << [item_id, item_title, category_id, category_name]
  #       end
  #     end
  #   end
  # end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Keyword.create!(row.to_hash)
    end
  end

  def rebay_find
    @rf ||= Rebay::Finding.new
  end

  def get_search_results
    rebay_find.find_items_by_keywords({keywords: text}).response["searchResult"]
  end

  def get_result_count
    rebay_find.find_items_by_keywords({keywords: text}).response["searchResult"]["@count"].to_i
  end

  def get_cat_id
    if self.get_result_count > 0
      rebay_find.find_items_by_keywords({keywords: text}).response["searchResult"]["item"]["primaryCategory"]["categoryId"]
    end
  end

  def rebay_shop
    @rs ||= Rebay::Shopping.new
  end

  def get_cat_info
    if self.get_cat_id
      rebay_shop.get_category_info({CategoryID: self.get_cat_id}).response["CategoryArray"]["Category"]["CategoryIDPath"]
    end
  end

end
