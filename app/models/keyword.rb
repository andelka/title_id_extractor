class Keyword < ApplicationRecord
  validates :text, presence: true

  def self.to_csv
    CSV.generate do |csv|
      csv << ["item_id", "item_title", "category_id", "category_name"]
      keywords = self.all
      keywords.each do |keyword|
        search_results = keyword.get_search_results
        parsed_search_results = JSON.parse(search_results.to_json)
        if items = search_results["item"]
          items.each do |item|
            item_id = item["itemId"]
            item_title = item["title"]
            category_id = item["primaryCategory"]["categoryId"]
            category_name = item["primaryCategory"]["categoryName"]
            csv << [item_id, item_title, category_id, category_name]
          end
        end
      end
    end
  end

  def rebay
    @rebay ||= Rebay::Finding.new
  end

  def get_search_results
    rebay.find_items_by_keywords({keywords: text}).response["searchResult"]
  end

end
