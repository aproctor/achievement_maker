require "rubygems"
require "bundler"
Bundler.setup(:default)

require './image_workshop'

first_line = "Owl: Hoo! It's been ages since these feathers could see this again..."

owl_say_image(first_line).write('image.png')

