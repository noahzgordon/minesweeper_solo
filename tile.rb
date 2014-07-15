class Tile
  
  NEIGHBOR_DELTAS = [
    [0, 1],
    [1, 0],
    [1, 1],
    [0, -1],
    [1, -1],
    [-1, 0],
    [-1, 1],
    [-1, -1]
  ]
  
  attr_reader :board, :position, :revealed, :flagged, :bombed
  
  def initialize(board, position, bombed = false)
    @board, @position, @bombed = board, position, bombed
    @revealed, @flagged = false, false
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
    neighbor_positions = NEIGHBOR_DELTAS.map do |delta| 
      [@position[0] + delta[0], @position[1] + delta[1]] 
    end
    
    neighbor_positions.reject! do |pos| 
      pos.any? { |coord| coord < 0 || coord >= board.grid_size } 
    end
    
    neighbor_positions.map { |pos| board.at(pos) }
  end
  
  def bombed_neighbors
    neighbors.count { |neighbor| neighbor.bombed }
  end
end