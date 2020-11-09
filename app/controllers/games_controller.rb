class GamesController < ApplicationController
  def new
    # new random grid and form
    alphabet = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
    @grid = 10.times.map { alphabet.sample }.join(' ')
  end

  def match(input, grid)
    input.chars.each do |letter|
      if input.count(letter) > grid.count(letter)
        return false
      end
    end
    return true
  end

  def score
    # POST request
    # the word is valid
    # the word isn't english
    # if word can't be built from those letters
    url = "https://wagon-dictionary.herokuapp.com/#{params[:answer]}"
    json_string = open(url).read
    @dictionary_result = JSON.parse(json_string)
    if @dictionary_result['found'] == true && match(params[:answer], params[:letters])
      @result = "Congratulations #{params[:answer]} is a valid English word!"
    else
      @result = "Sorry #{params[:answer]} does not seem to be a valid English word"
    end
  end
end
