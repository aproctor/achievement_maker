#!/usr/bin/env ruby

require "rubygems"
require "bundler"
Bundler.setup(:default)

require './achievement'
require 'sinatra'
require 'erb'
require 'instrumental_agent'

env = ENV['RACK_ENV'] || 'development'

I = Instrumental::Agent.new('7f51dd0b9bdb8a08b978ccbf94509914', :enabled => env == 'production')

get "/hoot/:text" do
  I.increment('generate_image')
  content_type 'image/png'
  response['Cache-Control'] = "public, max-age=#{60*24*7}" # cache for one week
  default_msg = "It's been ages since these feathers could see this again..."
  text = (params[:text] || default_msg).to_s.sub(/\.(jpeg|jpg|png|gif)$/i, '')
  achievement(text).to_blob
end

get "/" do
  I.increment('visit.homepage')
  erb :index
end
