module CinchHangman
  class Game
    def initialize(answer, max_guesses = 6)
      @answer            = answer
      @max_guesses       = max_guesses
      @correct_chars     = Set.new
      @incorrect_guesses = []
    end
    def guess(guess)
      guess.downcase!
      if @answer.include?(guess)
        @correct_chars.merge(guess.chars)
      else
        @incorrect_guesses << guess
      end
    end
    def describe
      if @correct_chars.empty? && @incorrect_guesses.empty?
        "(#{hint}) hangman started."
      elsif won
        "(#{hint}) hangman was solved!"
      elsif lost
        "(#{hint}) hangman was too difficult!"
      else
        "(#{hint}) #{guesses_left} guesses left."
      end
    end
    def won
      @correct_chars.superset?(Set.new(@answer.chars))
    end
    def lost
      guesses_left == 0
    end
    def guesses_left
      @max_guesses - @incorrect_guesses.size
    end
    def hint
      @answer.chars.map { |char| @correct_chars.include?(char) ? char : "_" }.join
    end
  end
end
