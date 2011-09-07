module Cinch::Plugins
  class Hangman
    include Cinch::Plugin
    match /hang guess (.*)/i,    :method => :guess
    match /hang new (.*) (.*)/i, :method => :new_game
    match /hang status/i,        :method => :status
    def new_game(m, channel, answer)
      @game = Game.new(answer)
      Channel(channel).send(@game.describe)
    end
    def guess(m, guess)
      @game.guess(guess)
      m.reply @game.describe
    end
    def status(m)
      m.reply @game.describe
    end
  end
  class Game
    def initialize(answer, max_guesses = 6)
      @answer            = answer
      @max_guesses       = max_guesses
      @correct_guesses   = []
      @incorrect_guesses = []
    end
    def guess(guess)
      if @answer.include?(guess)
        @correct_guesses << guess
      else
				@incorrect_guesses << guess
      end
    end
    def describe
      if @correct_guesses.empty? && @incorrect_guesses.empty?
        "(#{hint}) a new hangman riddle has started."
      elsif won
        "(#{hint}) that hangman riddle was solved, awesome!"
      elsif lost
        "(#{hint}) that hangman riddle was just too difficult, that sucks!"
      else
        "(#{hint}) #{guesses_left} guesses left on the current hangman riddle."
      end
    end
    def won
      @correct_guesses.join.include?(@answer)
    end
    def lost
      guesses_left == 0
    end
    def guesses_left
      @max_guesses - @incorrect_guesses.size
    end
    def hint
      @answer.chars.map { |char| @correct_guesses.join.include?(char) ? char : "_" }.join(" ")
    end

  end
end
