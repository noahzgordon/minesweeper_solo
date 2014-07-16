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
    @board.display
    
    until won? || lost?
      
      command, pos = get_input[0], get_input[1]
      
      case command
      when "click"
        click(pos)
      when "flag"
        flag(pos)
      when "save"
        self.save
      else
        command_list
      end
      
      @board.display
    end
    
    puts "You win!" if won?
    puts "You lose!" if lost?
  end
  
  def get_input
    puts "Please type in your command."
    command = gets.chomp.downcase
    
    if command == "save"
      self.save
      return nil
    end
    
    puts "Please input coordinates."
    coords = gets.chomp.split(',').map { |num| num.to_i - 1 }
    
    [command, coords]
  end
  
  def click(pos)
    @board[pos].reveal
  end
  
  def flag(pos)
    @board[pos].toggle_flag
  end
  
  def won?
    tiles = @board.rows.flatten
    
    tiles.none? { |tile| !tile.bombed && !tile.revealed }
  end
  
  def lost?
    tiles = @board.rows.flatten
    
    tiles.any? { |tile| tile.bombed && tile.revealed }
  end
  
  def command_list
    puts "The command you entered is invaid."
    puts "Valid commands include: 'click', 'flag', and 'save'."
  end
end