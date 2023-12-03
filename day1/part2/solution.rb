class CalibrationDocument
  attr_reader :calibration_values

  def initialize(file:)
    @file = file
    @calibration_values = []
  end

  def recover
    contents.each_line do |line|
      first_word = find_first_digit_as_word(line)
      line.sub!(first_word, words_to_digits) if first_word

      last_word = find_last_digit_as_word(line)
      line.sub!(last_word, words_to_digits) if last_word

      digit_chars = line.delete("^0-9").chars
      @calibration_values << (digit_chars[0] + digit_chars[-1]).to_i
    end
    self
  end

  private

  def contents
    File.read(File.join(__dir__, "..", @file))
  end

  def words_to_digits
    @words_to_digits ||= %w[one two three four five six seven eight nine].zip(1..9).to_h
  end

  def find_first_digit_as_word(line)
    min_index, first_word = line.size, nil
    words_to_digits.each_key do |word|
      if (index = line.index(word)) && index < min_index
        min_index = index
        first_word = word
      end
    end
    first_word
  end

  def find_last_digit_as_word(line)
    max_index, last_word = -1, nil
    words_to_digits.each_key do |word|
      if (index = line.index(word)) && index > max_index
        max_index = index
        last_word = word
      end
    end
    last_word
  end
end
