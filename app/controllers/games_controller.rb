require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @words = [*('A'..'Z')].sample(10)
  end
  
  def score
    @result = match? && valid?
  end
  
  def match?
    words = params['input_word']
    letters = params['word'].downcase
    words.chars.all? do |word| 
      letters.count(word) >= words.count(word) 
    end
  end

  def valid?
    JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{params['input_word']}").read)["found"]
  end
end
