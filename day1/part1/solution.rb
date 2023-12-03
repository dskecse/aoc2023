class CalibrationDocument
  attr_reader :calibration_values

  def initialize(file:)
    @file = file
    @calibration_values = []
  end

  def recover
    contents.each_line do |line|
      digit_chars = line.delete("^0-9").chars
      @calibration_values << (digit_chars[0] + digit_chars[-1]).to_i
    end
    self
  end

  private

  def contents
    File.read(File.join(__dir__, "..", @file))
  end
end
