class RemoveColumns < ActiveRecord::Migration
  def up
    remove_column :words, :japanese_meaning
  end

  def down
  end
end
