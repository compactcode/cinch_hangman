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
      describe 'correct' do 
        it 'when containing a single character in the answer' do
          subject.guess("h")
          subject.describe.should include '6 guesses'
        end
      end
      describe 'incorrect' do
        it 'when containing a single character not in the answer' do
          subject.guess("x")
          subject.describe.should include '5 guesses'
        end
        it 'when containing a word not in the answer' do
          subject.guess("lol")
          subject.describe.should include '5 guesses'
        end
        it 'when containing the correct answer in reverse' do
          subject.guess("ho")
          subject.describe.should include '5 guesses'
        end
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
      it 'occurs no matter what order guesses are given' do
        subject.guess("h")
        subject.guess("o")
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
