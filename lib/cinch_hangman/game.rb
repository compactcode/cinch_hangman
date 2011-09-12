module CinchHangman
  class Game
    MASK = "_"
    def initialize(answer, max_guesses = 6)
      @answer      = answer.downcase
      @max_guesses = max_guesses
      @guesses     = ""
    end
    def guess(guess)
      @guesses << guess.downcase.gsub(/[^a-z]/, "")
    end
    def describe
      if @guesses.empty?
        "(#{hint}) hangman started."
      elsif solved
        "(#{@answer}) was solved!"
      elsif guesses_left <= 0
        "(#{@answer}) was too difficult!"
      else
        "(#{hint}) #{guesses_left} guesses left. incorrect letters: #{incorrect_guesses}"
      end
    end
    def solved
      !hint.include?(MASK)
    end
    def guesses_left
      @max_guesses - @guesses.gsub(/[#{@answer}]/, "").size
    end
    def hint
      @answer.gsub(/[^\s#{@guesses}]/, MASK)
    end
    def incorrect_guesses
      ((@guesses.split(//) - @answer.split(//).uniq).sort).join
    end
    
  end
end
