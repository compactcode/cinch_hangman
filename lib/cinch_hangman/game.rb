module CinchHangman
  class Game
    def initialize(answer, max_guesses = 6)
      @answer      = answer
      @max_guesses = max_guesses
      @guesses     = ""
    end
    def guess(guess)
      @guesses << guess.downcase
    end
    def describe
      if @guesses.empty?
        "(#{hint}) hangman started."
      elsif solved
        "(#{hint}) hangman was solved!"
      elsif guesses_left <= 0
        "(#{hint}) hangman was too difficult!"
      else
        "(#{hint}) #{guesses_left} guesses left."
      end
    end
    def solved
      Set.new(@guesses.chars).superset?(Set.new(@answer.chars))
    end
    def guesses_left
      @max_guesses - @guesses.gsub(/[#{@answer}]/, "").size
    end
    def hint
      @answer.gsub(/[^ #{@guesses}]/, "_")
    end
  end
end
