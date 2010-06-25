#
# This is a Shoes app to visualize your game of life.
#

## REQUIRE YOUR OWN CLASS HERE ##
require 'game_of_life'
N, W = 20, 20

Shoes.app :title => 'Game of Life'do
  background khaki
  stroke pink
  
  def show_cells
    ## INSERT YOUR OWN CLASS WITH ITS ARGUMENTS HERE ##
    game = GameOfLife.new N
    cells = Array.new(N){Array.new N}
    N.times{|j| N.times{|i| cells[j][i] = rect 100+W*i, 50+W*j, W, W, :fill => white}}
    @e = every 1 do |n|
      @n.text = "Generation: #{n}"
      life = game.evolve
      N.times{|j| N.times{|i| cells[j][i].style :fill => (life[j][i].zero? ? white : green)}}
    end
  end
  
  gb = stack
  para link('start'){gb.clear{show_cells}}
  para link('stop'){@e.stop}
  @n = para
end
