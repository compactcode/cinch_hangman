require 'rubygems'

$:.unshift File.join(File.dirname(__FILE__), '..')

require 'cinch'
require 'cinch_hangman'

describe CinchHangman::Game do
  subject do
    CinchHangman::Game.new("oh")
  end
  describe 'game' do
    it 'should have a start' do
      subject.describe.should match /hangman.*started/
    end
    describe 'guesses' do
      describe 'correct' do 
        it 'when containing a single character from the answer' do
          subject.guess("h")
          subject.describe.should include '6 guesses'
        end
        it 'when containing a single character from the answer in the wrong case' do
          subject.guess("H")
          subject.describe.should include '6 guesses'
        end
      end
      describe 'incorrect' do
        it 'when containing a single character not in the answer' do
          subject.guess("x")
          subject.describe.should include '5 guesses'
        end
        it 'when containing multiple characters not in the answer' do
          subject.guess("cat")
          subject.describe.should include '3 guesses'
        end
      end
    end
    describe 'hints' do
      it 'show the number of letters in the answer' do
        subject.guess("x")
        subject.describe.should include '__'
      end
      it 'show letters that have been guessed correctly' do
        subject.guess("h")
        subject.describe.should include '_h'
      end
    end
    describe 'winning' do
      it 'occurs when the answer is guessed using individual characters' do
        subject.guess("o")
        subject.guess("h")
        subject.describe.should include 'solved!'
      end
      it 'occurs when the answer is guessed in one go' do
        subject.guess("oh")
        subject.describe.should include 'solved!'
      end
      it 'occurs when the answer is given with a mixture of approaches' do
        subject.guess("o")
        subject.guess("oh")
        subject.describe.should include 'solved!'
      end
      it 'occurs no matter what order guesses are given' do
        subject.guess("h")
        subject.guess("o")
        subject.describe.should include 'solved!'
      end
      it 'should not be automatic for hassox' do
        subject = CinchHangman::Game.new("hassox")
        subject.guess("s")
        subject.describe.should_not include 'solved!'
      end
    end
    describe 'losing' do
      it 'occurs when all the guesses run out' do
        6.times do
          subject.guess("z")
        end
        subject.describe.should include 'too difficult!'
      end
    end
  end
end
