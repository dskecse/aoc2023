require "minitest/autorun"
require_relative "solution"

class TestGame < Minitest::Test
  def setup
    @game = Game.new(1, [{ red: 1, green: 2, blue: 3 }, { red: 0, green: 9, blue: 2 }])
  end

  def test_initializes_a_game_object_with_the_right_data
    assert_equal 1, @game.id
    assert_equal({ red: 1, green: 2, blue: 3 }, @game.subsets[0])
    assert_equal({ red: 0, green: 9, blue: 2 }, @game.subsets[1])
  end

  def test_responds_to_possible?
    assert_respond_to @game, :possible?
  end

  def test_returns_true_if_all_subsets_possible_with_a_game_config_provided
    config = { red: 1, green: 9, blue: 6 }
    assert @game.possible?(config)
  end

  def test_returns_false_if_any_of_subsets_are_impossible_with_a_game_config_provided
    config = { red: 1, green: 3, blue: 6 }
    refute @game.possible?(config)
  end
end

class TestPuzzle < Minitest::Test
  def setup
    config = { red: 12, green: 13, blue: 14 }
    @puzzle = Puzzle.new(input: "input.txt", config:)
  end

  def test_loads_games_on_init
    assert_equal 100, @puzzle.games.size
  end

  def test_responds_to_possible_game_ids
    assert_respond_to @puzzle, :possible_game_ids
  end

  def test_returns_game_ids_that_are_possible
    refute_empty @puzzle.possible_game_ids
  end

  def test_responds_to_solve
    assert_respond_to @puzzle, :solve
  end

  def test_returns_the_valid_sum_of_possible_game_ids
    assert_equal 1853, @puzzle.solve
  end
end
