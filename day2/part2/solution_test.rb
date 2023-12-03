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

  def test_responds_to_smallest_possible_config
    assert_respond_to @game, :smallest_possible_config
  end

  def test_returns_valid_smallest_possible_config
    assert_equal({ red: 1, green: 9, blue: 3 }, @game.smallest_possible_config)
  end
end

class TestPuzzle < Minitest::Test
  def setup
    config = { red: 12, green: 13, blue: 14 }
    @puzzle = Puzzle.new(input: "example.txt", config:)
  end

  def test_loads_games_on_init
    assert_equal 5, @puzzle.games.size
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
    assert_equal 8, @puzzle.solve
  end

  def test_responds_to_smallest_possible_game_configs
    assert_respond_to @puzzle, :smallest_possible_game_configs
  end

  def test_returns_smallest_possible_game_configs
    assert_equal [
      { red: 4,  green: 2,  blue: 6 },
      { red: 1,  green: 3,  blue: 4 },
      { red: 20, green: 13, blue: 6 },
      { red: 14, green: 3,  blue: 15 },
      { red: 6,  green: 3,  blue: 2 }
    ], @puzzle.smallest_possible_game_configs
  end

  def test_respond_to_game_config_powers
    assert_respond_to @puzzle, :game_config_powers
  end

  def test_returns_game_config_powers
    assert_equal [48, 12, 1560, 630, 36], @puzzle.game_config_powers
  end

  def test_returns_the_right_powers_sum
    assert_equal 2286, @puzzle.powers_sum
  end
end
