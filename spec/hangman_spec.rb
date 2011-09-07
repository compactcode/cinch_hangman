require 'rubygems'

$:.unshift File.join(File.dirname(__FILE__), '..')

require 'cinch'
require 'cinch_hangman'

describe Cinch::Plugins::Game do
  subject do
    Cinch::Plugins::Game.new("oh")
  end
  describe 'game' do
    it 'should have a start' do
      subject.describe.should include 'new hangman'
    end
    describe 'guesses' do
      it 'reduce after an incorrect guess' do
        subject.guess("x")
        subject.describe.should include '5 guesses'
        subject.guess("lol")
        subject.describe.should include '4 guesses'
      end
      it 'do not reduce after a correct guess' do
        subject.guess("h")
        subject.describe.should include '6 guesses'
      end
    end
    describe 'hints' do
      it 'show the number of letters in the answer' do
        subject.guess("x")
        subject.describe.should include '_ _'
      end
      it 'show letters that have been guessed correctly' do
        subject.guess("h")
        subject.describe.should include '_ h'
      end
    end
    describe 'winning' do
      it 'occurs when the answer is guessed using individual characters' do
        subject.guess("o")
        subject.guess("h")
        subject.describe.should include 'awesome!'
      end
      it 'occurs when the answer is guessed in one go' do
        subject.guess("oh")
        subject.describe.should include 'awesome!'
      end
      it 'occurs when the answer is given with a mixture of approaches' do
        subject.guess("o")
        subject.guess("oh")
        subject.describe.should include 'awesome!'
      end
      it 'should not be automatic for hassox' do
        subject = Cinch::Plugins::Game.new("hassox")
        subject.guess("s")
        subject.describe.should_not include 'awesome!'
      end
    end
    describe 'losing' do
      it 'occurs when all the guesses run out' do
        6.times do
          subject.guess("z")
        end
        subject.describe.should include 'sucks!'
      end
    end
  end
end
