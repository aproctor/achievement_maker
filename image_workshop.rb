require 'digest/md5'
require 'faraday'
require 'RMagick'

#Shamelessly stolen from rails
def word_wrap(text, options = {})
  line_width = options.fetch(:line_width, 30)

  text.split("\n").collect! do |line|
    line.length > line_width ? line.gsub(/(.{1,#{line_width}})(\s+|$)/, "\\1\n").strip : line
  end * "\n"
end

def owl_image()
  client = Faraday::Connection.new(:url => "http://i.imgur.com/")
  owlsay_background = "/6Pemy4t.png"
  return client.get(owlsay_background).body
end

def owl_say_image(first_line)
  canvas = Magick::Image.new(359, 139) { |c| c.background_color = "none"; c.format = "png" }
  draw = Magick::Draw.new


  oimg = Magick::Image.from_blob(owl_image).first
  draw.composite(0, 0, 359, 139, oimg)

  draw.fill("#FFFFFF")
  draw.font('fonts/Helvetica.ttf')
  draw.font_size('15.5')
  draw.kerning('0.65')
  draw.text(100,40, word_wrap(first_line))

  draw.draw(canvas)

  return canvas
end
