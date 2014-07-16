# encoding: UTF-8

require './tile.rb'

class Board
  
  DIFF_CONVERSIONS = {
    :easy => { :size => 9, :bombs => 16 },
    :medium => { :size => 16, :bombs => 40 },
    :hard => { :size => 32, :bombs => 160 }
  }
  
  attr_reader :rows, :grid_size
  
  def initialize(difficulty = :easy)
    @grid_size = DIFF_CONVERSIONS[difficulty][:size]
    @rows = self.generate_board(difficulty)
    populate_board(difficulty)
  end
  
  def display
    num_line = '  '
    1.upto(grid_size) do |num|
      num < 9 ? num_line += num.to_s + '   ' : num_line += num.to_s + '  '
    end
    
    puts num_line
    puts '┌' + '───┬' * (@grid_size - 1) + '───┐'
    @rows.reverse.each_with_index do |row, i|
      puts '│ ' + row.map { |tile| tile.render }.join(' │ ') + ' │' + "  #{@grid_size - i}"
      puts '├─' + ('──┼─' * (@grid_size - 1)) + '──┤' unless row == @rows[0]
    end
    puts '└' + '───┴' * (@grid_size - 1) + '───┘'
    
    nil
  end
  
  def generate_board(difficulty)
    Array.new(@grid_size) { Array.new(@grid_size) { nil } }
  end
  
  def populate_board(difficulty)
    num_of_bombs = DIFF_CONVERSIONS[difficulty][:bombs]
    bomb_positions = []
    
    until bomb_positions.count == num_of_bombs
      bomb_positions << [(0...@grid_size).to_a.sample, (0...@grid_size).to_a.sample]
    end
    
    @rows.each_with_index do |row, y|
      row.each_with_index do |space, x|
        position = [x, y]
        bombed = bomb_positions.include? position
        
        tile = Tile.new(self, position, bombed)
        set([x, y], tile) 
      end
    end
  end
  
  def [](pos)
    # intended to return the position as if it were a regular x/y grid
    @rows[pos[1]][pos[0]]
  end
  
  def set(pos, tile)
    @rows[pos[1]][pos[0]] = tile
  end
end