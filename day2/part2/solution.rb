Game = Data.define(:id, :subsets) do
  def possible?(config)
    subsets.all? do
      _1[:red] <= config[:red] &&
      _1[:green] <= config[:green] &&
      _1[:blue] <= config[:blue]
    end
  end

  def smallest_possible_config
    max = { red: 0, green: 0, blue: 0 }
    subsets.each do |subset|
      subset.each do |color, num|
        max[color] = num if num > max[color]
      end
    end
    max
  end
end

class Puzzle
  attr_reader :games

  def initialize(input:, config:)
    @input = input
    @config = config
    @games = load_games
  end

  def possible_game_ids
    @possible_game_ids ||= games.select { _1.possible?(@config) }.map(&:id)
  end

  def solve
    possible_game_ids.sum
  end

  def smallest_possible_game_configs
    @smallest_possible_game_configs ||= games.map(&:smallest_possible_config)
  end

  def game_config_powers
    smallest_possible_game_configs.map { _1.values.reduce(:*) }
  end

  def powers_sum
    game_config_powers.sum
  end

  private

  def contents
    File.read(File.join(__dir__, "..", @input))
  end

  def load_games
    contents.each_line.map do |game_info|
      game_id, game_subsets = game_info.split(": ")
      _, id = game_id.split
      game_subsets = game_subsets.strip.split("; ")

      subsets = []
      game_subsets.map { _1.split(", ") }.each do |game_subset|
        subset = { red: 0, green: 0, blue: 0 }
        game_subset.each do |cube_info|
          num, color = cube_info.split
          subset[color.to_sym] = Integer(num)
        end
        subsets.push(subset)
      end
      Game.new(Integer(id), subsets)
    end
  end
end
