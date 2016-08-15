require "set"
require "byebug"

class Game
  attr_accessor :fragment, :players, :dictionary, :losses



  def initialize(*players)
    @players = players

    @dictionary = Set.new(File.readlines("dictionary.txt").map(&:chomp))
    @losses = {
      players.first => 0,
      players.last  => 0
    }
  end

  def current_player
    players.first
  end

  def previous_player
    players.last
  end

  def next_player!
    a = players.first

    b = players.last

    players[1] = a

    players[0] = b

    #players.first, players.last = players.last, players.first
  end

  def take_turn(player)
    choice = player.guess
    until valid_play?(choice)
      puts "The fragment is now: #{fragment}"
      puts "Enter a string please, #{player.name}, again: "
      print "> "
      choice =  $stdin.gets.chomp
    end

    @fragment << choice
    if dictionary.include?(fragment)
      losses[current_player] += 1
      puts "#{current_player.name} loses!\n"
    end
    puts "The fragment is now: #{fragment}"
  end

  def valid_play?(string)
    unless ("a".."z").include?(string)
      return false
    end

    dictionary.each do |word|
      if word.include?(fragment + string)
        return true
      end
    end
    return false
  end

  def play_round
    @fragment = ""
    until dictionary.include?(fragment)
      take_turn(players.first)
      next_player!
    end
  end

  def run
    play_round until game_over?
  end

  def game_over?
    (losses[players.first] == 5) || (losses[players.last] == 5)
  end



end

class Player
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def guess
    puts "Enter a string please, #{name}: "
    print "> "

    guess = $stdin.gets.chomp
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Game.new(Player.new("Ashok"), Player.new("Yisheng"))
  game.run
end
