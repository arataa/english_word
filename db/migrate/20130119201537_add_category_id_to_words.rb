class AddCategoryIdToWords < ActiveRecord::Migration
  def change
    add_column :words, :category_id, :integer
  end
end
