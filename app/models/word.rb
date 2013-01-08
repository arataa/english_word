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

  def self.update_from_text(file_name)
    file = File.open(file_name)

    file.each do |line|
      english_meaning = ""
      japanese_meaning = ""
      if line.to_s.size > 0 
        match =  line.to_s.scan(/(.*)=(.*)\n/)
        unless match[0].nil?
          english = match[0][0].strip
          #if /[^ -~｡-']/ =~ match[0][1]
          #  japanese_meaning = match[0][1]
          #else
            english_meaning = match[0][1].strip
          #end
          update(english, english_meaning, japanese_meaning)
        end
      end
    end
  end

  def self.updates(words)
    words.each do |word|
      update(word[:english], word[:english_meaning], word[:japanese_meaning])
    end
  end

end
