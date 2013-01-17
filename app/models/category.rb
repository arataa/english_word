class Category < ActiveRecord::Base
  belongs_to :word
  attr_accessible :name
  def self.update(name)
    new_category = where("name = ?",name).first
    new_category              ||= new()
    new_category.name           = name
    new_category.save
  end
end
