#!/usr/bin/env ruby

require "rubygems"
require "bundler"
Bundler.setup(:default)

require './image_workshop'
require 'sinatra'
require 'erb'

env = ENV['RACK_ENV'] || 'development'

get "/hoot/:text" do
  content_type 'image/png'
  response['Cache-Control'] = "public, max-age=#{60*24*7}" # cache for one week

  text = params[:text]
  text = "Owl: Hoo! It's been ages since these feathers could see this again..." if(!text.match(/[^[:space:]]/) || text == "default")

  text = text.to_s.sub(/\.(jpeg|jpg|png|gif)$/i, '')

  return owl_say_image(text).to_blob
end

get "/slow/:text" do
  content_type 'image/png'
  response['Cache-Control'] = "public, max-age=#{60*24*7}" # cache for one week

  text = params[:text]
  text = "Hey" if(!text.match(/[^[:space:]]/) || text == "default")

  text = text.to_s.sub(/\.(jpeg|jpg|png|gif)$/i, '')

  return slowsay_image(text).to_blob
end

get "/" do
  erb :index
end
