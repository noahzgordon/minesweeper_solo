require './board'
require 'yaml'

class Minesweeper
  
  def self.save(filename)
    File.write("#{filename}.yml", YAML.dump(self))
  end
  
  def self.load(filename)
    game = File.read("./#{filename}.yml")
    YAML.parse(game)
  end
  
  def initialize(difficulty = :easy)
    @board = Board.new(difficulty)
  end
  
  def play
    @board.display
    
    until won? || lost?
      
      command, pos = get_input
      
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

if __FILE__ == $PROGRAM_NAME
  puts "Would you like to LOAD a previous game or start a NEW game?"
  input = gets.chomp.downcase
  
  if input == 'new'
    puts "Choose a difficulty: EASY, MEDIUM, or HARD."
    diff = gets.chomp.downcase
    
    Minesweeper.new(diff.to_sym).play
  elsif input == 'load'
    puts "What is the name of your save file?"
    filename = gets.chomp.downcase
    
    Minesweeper.load(filename).play
  end
end
    
  
  
  