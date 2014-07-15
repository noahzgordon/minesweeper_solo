class Tile
  
  attr_reader :board, :position, :revealed, :flagged, :bombed
  
  def initialize(board, position)
    @board, @position = board, position
    @revealed, @flagged, @bombed = false, false, false
  end
  
end