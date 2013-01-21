class Category < ActiveRecord::Base
  has_many :word
  attr_accessible :name
  def self.update(name)
    new_category = where("name = ?",name).first
    new_category              ||= new()
    new_category.name           = name
    new_category.save
  end
end
