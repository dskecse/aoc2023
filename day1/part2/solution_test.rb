require "minitest/autorun"
require_relative "solution"

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
    assert_equal [29, 83, 13, 24, 42, 14, 76, 35, 52, 91, 21, 52], @calibration_document.recover.calibration_values
  end

  def test_returns_the_valid_sum_of_calibration_values
    assert_equal 532, @calibration_document.recover.calibration_values.sum
  end
end
