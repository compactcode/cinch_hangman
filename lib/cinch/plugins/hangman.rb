module Cinch::Plugins
  class Hangman
    include Cinch::Plugin
    match /hang guess (.*)/i,      :method => :guess
    match /hang new (#\S*) ([\sa-zA-Z0-9]*)/i, :method => :new_game
    def new_game(m, channel, answer)
      @game = CinchHangman::Game.new(answer)
      Channel(channel).send(@game.describe)
    end
    def guess(m, guess)
      @game.guess(guess)
      m.reply @game.describe
    end
  end
end
