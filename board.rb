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
    @rows.reverse.each do |row|
      puts row.map { |tile| tile.render }.join(' ')
    end
  end
  
  private
  
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
  
  def at(pos)
    # intended to return the position as if it were a regular x/y grid
    @rows.reverse[pos[1]][pos[0]]
  end
  
  def set(pos, tile)
    @rows.reverse[pos[1]][pos[0]] = tile
  end
end