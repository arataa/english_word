class Category < ActiveRecord::Base
  has_many :word
  attr_accessible :name

  def self.updates(words)
    categories.each do |category|
      category_tmp = find(category.id)
      category_tmp.update_attributes(category) unless category_tmp.nil?
      category_tmp != new(category) 
      category_tmp.save
    end
  end
end
