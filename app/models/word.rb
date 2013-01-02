class Word < ActiveRecord::Base
  attr_accessible :count, :english_meaning, :english, :japanese_meaning

  def self.update(english, english_meaning, japanese_meaning)
    new_word = where("english = ?",english).first
    new_word                  ||= new()
    new_word.english          = english
    new_word.english_meaning  = english_meaning
    new_word.japanese_meaning = japanese_meaning
    new_word.save
  end
end
