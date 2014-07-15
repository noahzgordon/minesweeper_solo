require './board'
require 'yaml'

class Minesweeper
  
  def self.save
    
  end
  
  def self.load
    
  end
  
  def initialize(difficulty = :easy)
    @board = Board.new(difficulty)
  end
  
  def play
    
    until won? || lost?
      
      command, pos = get_input
      
      case command
      when "click"
        click(pos)
      when "flag"
        flag(pos)
      when "save"
        self.save
      end
      
      
      
    end
    
  end
  
  def get_input
    #returns [command, pos]
  end
  
  def click(pos)
    
  end
  
  def flag(pos)
    
  end
  
  
  def won?
    
  end
  
  def lost?
    
  end
  
end