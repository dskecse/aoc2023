Game = Data.define(:id, :subsets) do
  def possible?(config)
    subsets.all? do
      _1[0] <= config[0] && _1[1] <= config[1] && _1[2] <= config[2]
    end
  end
end

class Puzzle
  attr_reader :games

  def initialize(input:, config:)
    @input = input
    @config = config # [r, g, b]
    @games = load_games
  end

  def possible_game_ids
    @possible_game_ids ||= games.select { _1.possible?(@config) }.map(&:id)
  end

  def solve
    possible_game_ids.sum
  end

  private

  CUBE_COLOR_TO_POSITION = %w[red green blue].zip(0..2).to_h
  private_constant :CUBE_COLOR_TO_POSITION

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
        subset = [0] * 3
        game_subset.each do |cube_info|
          num, color = cube_info.split
          subset[CUBE_COLOR_TO_POSITION[color]] = Integer(num)
        end
        subsets.push(subset)
      end
      Game.new(Integer(id), subsets)
    end
  end
end
