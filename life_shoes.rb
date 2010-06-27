#
# This is a Shoes app to visualize your game of life.
#

## REQUIRE YOUR OWN CLASS HERE ##
require 'game_of_life'
W = 20 # cell width

Shoes.app :title => 'Game of Life'do
  background khaki
  stroke pink
  
  def initialize_cells(life)
    @height = life.size
    @width = life.first.size
    @cells = Array.new(@height){Array.new @width}
    @height.times{|j| @width.times{|i| @cells[j][i] = rect 100+W*i, 50+W*j, W, W, :fill => white}}
    @initialized = true
  end

  def show_cells
    ## INSERT YOUR OWN CLASS WITH ITS ARGUMENTS HERE ##
    game = GameOfLife.new 30
    @e = every 1 do |n|
      @n.text = "Generation: #{n}"
      life = game.evolve
      @initialized ||= initialize_cells(life)
      @height.times{|j| @width.times{|i| @cells[j][i].style :fill => (life[j][i].zero? ? white : green)}}
    end
  end
  
  gb = stack
  para link('start'){gb.clear{show_cells}}
  para link('stop'){@e.stop}
  @n = para
end
