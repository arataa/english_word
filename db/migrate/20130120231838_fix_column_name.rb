class FixColumnName < ActiveRecord::Migration
  def up
  end

  def change
    rename_column :words,   :english, :word
    rename_column :words,   :english_meaning, :meaning
  end

  def down
  end
end
