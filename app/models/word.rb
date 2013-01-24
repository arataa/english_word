class Word < ActiveRecord::Base
  belongs_to :category
  attr_accessible :category_id, :count, :meaning, :word

  def set_test_result correct
    count += 1
    correct_count += correct
    update
    return 
  end
  
  def self.get_test_word(category_id)
    words = where("category_id = ?",category_id).order("correct_count, updated_at ASC").limit(10)
    return if words.size() == 0
    max   = words.size() > 10 ? 9 : words.size() - 1
    index = Random.rand(0..max)
    return words[index]
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
      word_tmp = find(word.id)
      word_tmp.update_attributes(word) unless word_tmp.nil?
      word_tmp != new(word) 
      word_tmp.save
    end
  end

end
