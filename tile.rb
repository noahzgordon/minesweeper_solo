class Tile
  
  NEIGHBOR_DELTAS = [
    [0, 0],
    [0, 1],
    [1, 0],
    [1, 1],
    [0, -1],
    [-1, 0],
    [-1, 1],
    [-1, -1]
  ]
  
  attr_reader :board, :position, :revealed, :flagged, :bombed
  
  def initialize(board, position)
    @board, @position = board, position
    @revealed, @flagged, @bombed = false, false, false
  end
  
  def place_bomb
    @bombed = true
  end
  
  def toggle_flag
    @flagged ? @flagged = :false : @flagged = true
  end
  
  def reveal
    if bombed_neighbors == 0 && !bombed
      neighbors.each do |neighbor| 
        neighbor.reveal unless neighbor.flagged || neighbor.revealed
      end
    end
    
    @revealed = true
  end
  
  def neighbors
    neighbors = NEIGHBOR_DELTAS.map do |delta| 
      [@position[0] + delta[0], @position[1] + delta[1]] 
    end
    
    neighbors.reject do |pos| 
      pos.any? { |coord| coord < 0 || coord >= board.rows.length } 
    end
    
    neighbors
  end
  
  def bombed_neighbors
    neighbors.count { |neighbor| neighbor.bombed }
  end
end