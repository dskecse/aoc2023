require "minitest/autorun"
require_relative "solution"

class TestGame < Minitest::Test
  def setup
    @game = Game.new(1, [[1, 2, 3], [0, 9, 2]])
  end

  def test_initializes_a_game_object_with_the_right_data
    assert_equal 1, @game.id
    assert_equal [1, 2, 3], @game.subsets[0]
    assert_equal [0, 9, 2], @game.subsets[1]
  end

  def test_responds_to_possible?
    assert_respond_to @game, :possible?
  end

  def test_returns_true_if_all_subsets_possible_with_a_game_config_provided
    assert @game.possible?([1, 9, 6])
  end

  def test_returns_false_if_any_of_subsets_are_impossible_with_a_game_config_provided
    refute @game.possible?([1, 3, 6])
  end
end

class TestPuzzle < Minitest::Test
  def setup
    @puzzle = Puzzle.new(input: "example.txt", config: [12, 13, 14])
  end

  def test_loads_games_on_init
    assert_equal 5, @puzzle.games.size
  end

  def test_responds_to_possible_game_ids
    assert_respond_to @puzzle, :possible_game_ids
  end

  def test_returns_game_ids_that_are_possible
    assert_equal [1, 2, 5], @puzzle.possible_game_ids
  end

  def test_responds_to_solve
    assert_respond_to @puzzle, :solve
  end

  def test_returns_the_valid_sum_of_possible_game_ids
    assert_equal 8, @puzzle.solve
  end
end
