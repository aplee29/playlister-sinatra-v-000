require 'rack-flash'

class SongsController < ApplicationController
  use Rack::Flash

  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end

  get '/songs/new' do
    erb :'/songs/new'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/show'
  end

  post '/songs' do
    @song = Song.create(
      name: params[:name], 
      artist: Artist.find_or_create_by(name: params[:artist]),
      genre_ids: params[:genres]
    )

    flash[:message] = "Successfully created song."
    redirect to "/songs/#{@song.slug}"
  end

  get '/songs/:slug/edit' do 
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/edit'
  end

  patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @song.update(artist: Artist.find_or_create_by(name: params[:artist][:name]))

    flash[:message] = "Successfully updated song."
    redirect to "/songs/#{@song.slug}"
  end
  
end