#
# This is a class to allow you to visualize your game of life with ncurses.
#
# howto
# if your class is called GameOfLife
#    LifeNcurses.new(GameOfLife.new(...))
# with ... the paramters that your initialize method takes
#
# this should show you the game of life evolving in your terminal
# there is a second optional parameter for the number of generations you want to see
#    LifeNcurses.new(GameOfLife.new(...),5)
# if you want to see only 5 generations

require 'rubygems'
require 'ffi-ncurses'

class LifeNcurses

  # spaces from the border of the terminal
  MARGIN = 2
  include FFI::NCurses

  def initialize(game_of_life,iterations=100)
    @stdscr = initscr
    cbreak
    (1..iterations).each do |generation|
      clear
      display_title(generation)
      show game_of_life.evolve
    end 
  ensure
    endwin
  end

  def show(state)
    state.each_with_index do |row,row_index|
      row.each_with_index do |col, col_index|
        mvwaddstr @stdscr, row_index+MARGIN, col_index+MARGIN, '#' if state[row_index][col_index] == 1
      end
    end
    refresh
    sleep 1 
  end

  def display_title(generation)
    mvwaddstr @stdscr, 0, 1, "Game of life: Generation #{generation}"
  end

end
