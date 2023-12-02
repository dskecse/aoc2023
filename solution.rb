require "minitest/autorun"

class TestCalibrationDocument < Minitest::Test
  def setup
    @calibration_document = CalibrationDocument.new(file: "example.txt")
  end

  def test_calibration_values_is_initially_an_empty_array
    assert_equal [], @calibration_document.calibration_values
  end

  def test_responds_to_recover
    assert_respond_to @calibration_document, :recover
  end

  def test_recovers_calibration_document
    assert_equal [12, 38, 15, 77], @calibration_document.recover.calibration_values
  end

  def test_returns_the_valid_sum_of_calibration_values
    assert_equal 142, @calibration_document.recover.calibration_values.sum
  end
end

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
    File.read(@file)
  end
end
