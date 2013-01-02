class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :english
      t.string :english_meaning
      t.string :japanese_meaning
      t.integer :count

      t.timestamps
    end
  end
end
