require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:guess]}"
    user_serialized = URI.open(url).read
    user = JSON.parse(user_serialized)

    if user["found"] == false
      @message = "Sorry but #{params[:guess]} does not seem to be a valid English word."
    else
      @message = "Congratulations! #{params[:guess]} is a valid English word!"
    end
    @guess = []
    params[:guess].each_char do |letter|
       @guess << letter.upcase!
    end
    @grid = params[:grid].split
    @guess.each do |letter|
      if @grid.include?(letter)
        @grid.slice!(@grid.index(letter))
      else
        @message = "Sorry but #{params[:guess]} can't be built out of #{@grid}"
      end
   end
  end
end
