class Keyword < ApplicationRecord
  validates :text, presence: true

  def self.to_csv
    CSV.generate do |csv|
      csv << ["item_id", "item_title", "category_id", "category_name"]
      keywords = self.all
      keywords.each do |keyword|
        items = keyword.get_items
        parsed_items = JSON.parse(items.to_json)
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

  def rebay
    @rebay ||= Rebay::Finding.new
  end

  def get_items
    rebay.find_items_by_keywords({keywords: text}).response["searchResult"]["item"]
  end

end
