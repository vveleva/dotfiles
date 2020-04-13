BLOCK_WIDTH = 11
SPACE = (' ' * 4).freeze

HEX_COLORS = {
  black:   "#263338", light_black:   "#1e2b30",
  red:     "#dc312e", light_red:     "#cb4a16",
  green:   "#859901", light_green:   "#586d74",
  yellow:  "#b58900", light_yellow:  "#657b82",
  blue:    "#268ad2", light_blue:    "#839495",
  magenta: "#d33582", light_magenta: "#6c6ec6",
  cyan:    "#2aa197", light_cyan:    "#93a0a1",
  white:   "#eee8d5", light_white:   "#fdf6e3",
}.freeze

# use this as a reference of the colors order
TERMINAL_COLOR_NAMES = [
  :black,
  :red,
  :green,
  :yellow,
  :blue,
  :magenta,
  :cyan,
  :white,
  :light_black,
  :light_red,
  :light_green,
  :light_yellow,
  :light_blue,
  :light_magenta,
  :light_cyan,
  :light_white,
].freeze

TERMINAL_HUE = [
  :light_black,
  :black,
  :light_green,
  :light_yellow,
  :light_blue,
  :light_cyan,
  :white,
  :light_white,

  :red,
  :light_red,
  :yellow,
  :green,
  :cyan,
  :blue,
  :light_magenta,
  :magenta,
].freeze

COLOR_CODES = Hash.new(9).update(
  black:   0, light_black:   60,
  red:     1, light_red:     61,
  green:   2, light_green:   62,
  yellow:  3, light_yellow:  63,
  blue:    4, light_blue:    64,
  magenta: 5, light_magenta: 65,
  cyan:    6, light_cyan:    66,
  white:   7, light_white:   67,
  default: 9
).freeze

MODE_CODES = Hash.new(0).update(
  default:   0, # Turn off all attributes
  bold:      1, # Set bold mode
  italic:    3, # Set italic mode
  underline: 4, # Set underline mode
  blink:     5, # Set blink mode
  swap:      7, # Exchange foreground and background colors
  hide:      8  # Hide text (foreground color would be the same as background)
).freeze

def color(color)
  COLOR_CODES[color] + 30
end

def background_color(color)
  COLOR_CODES[color] + 40
end

def mode(mode)
  MODE_CODES[mode]
end

def colorize(mode: :blink, fg: :default, bg: :default, text:)
  "\033[#{mode(mode)};#{color(fg)};#{background_color(bg)}m#{text}\033[0m"
end

def format_text(text, width:)
  text.to_s.gsub('light_', 'b ').upcase.center(width || BLOCK_WIDTH)
end

def color_fg(text: '', color:)
  color = [:black, :light_black].include?(color) ? :light_yellow : color
  colorize(fg: color, text: format_text(text, width: nil))
end

def color_bg(text: '', color:, width: nil)
  color_fg = [:black, :light_black].include?(color) ? :light_yellow : :black
  colorize(fg: color_fg, bg: color, text: format_text(text, width: width))
end

blocks = TERMINAL_COLOR_NAMES.map do |color|
  [
    color_bg(text: HEX_COLORS[color], color: color),
    color_fg(text: color, color: color),
  ]
end

slices = blocks.each_slice(8).map do |block_arr|
  # block_arr[0].zip(*block_arr[1..-1]).map { |arr| arr.join('  ') }
  spaces = [SPACE + ' ' * 3] * block_arr[0].length
  spaces.zip(*block_arr).map { |arr| arr.join(' ') }
end


hue_blocks = TERMINAL_HUE.map do |color|
  width = 13
  [
    color_bg(color: color, width: width),
    color_bg(text: HEX_COLORS[color], color: color, width: width),
    color_bg(text: color, color: color, width: width),
    color_bg(color: color, width: width),
  ]
end

hue_slices = hue_blocks.each_slice(8).map do |block_arr|
  # block_arr[0].zip(*block_arr[1..-1]).map { |arr| arr.join('') }
  spaces = [SPACE] * block_arr[0].length
  spaces.zip(*block_arr).map(&:join)
end


separator = colorize(mode: :underline, fg: :black, text: ' ' * (8 * 13) + SPACE * 2)

puts ''
puts separator
puts ''
puts ''

slices.each do |slice|
  puts slice
end

puts ''
puts separator
puts ''
puts ''

hue_slices.each do |slice|
  puts slice
end

puts ''
puts separator
puts ''
puts ''
