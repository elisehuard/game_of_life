## Ruby Programming Challenge: Game of Life ##

The idea is to implement the game of life in Ruby.
The game of life is a simplified model of evolution and natural selection invented by a mathematician called James Conway. It is described [here](http://en.wikipedia.org/wiki/Conway's_Game_of_Life).

# Rules #
You have a grid of cells in 2 dimensions.  Each cell has 2 possible states, alive or dead.  Each cell has 8 neighbours: above, below, left, right, and the 4 diagonals.

* any life cell < 2 neighbours dies 
* any life cell > 3 neighbours dies
* any live cell with 2 or 3 neighbours lives to next generation
* any dead cell with exactly 3 live neighbours becomes a live cell

edges of game: just pretend that the board is folded onto itself, and the edges touch each other. If that's too complicated, you can work without that assumption.


# Your job #
The idea is that you implement a class that will have the following methods:

* initialize: will randomly initialize the game of life matrix. I leave you to think of parameters to use: size, width, height, number of seeds to initialize ... ([for inspiration](http://people.bridgewater.edu/~rbowman/ISAW/Life.html)  )
* evolve: this implements the evolution according to the game of life rules (see above).  Every time evolve is called, one step of the game of life is executed. 
The evolve methods should return:
an array of arrays - which represents an array of rows.  Where there's life (a live cell), there's a 1, where there's no life (a dead cell), there's a 0.

So:

    g = GameOfLife.new # say we have 5x5 default
    => #<GameOfLife:0x1010557d8>
    g.evolve
    => [[0, 1, 0, 0, 0], [1, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]] 

* state=(array) accessor to set the state from outside. This allows us to test whether your evolve method obeys the rules (can also be useful for your own tests).  Regardless of your internal state representation this method should take the same type of parameter as produced by evolve (an array of rows).

# To test your implementation #
Test-driven development is always a good idea.  I added a Test::Unit class as a *simplified* example, but really, try to do TDD (http://en.wikipedia.org/wiki/Test-driven_development).

# To visualize your implementation #

## life_ncurses

This requires the gem ffi-ncurses.
    gem install ffi ffi-ncurses

If you get a dlopen error, you should install one of the forks:
    git clone http://github.com/stepheneb/ffi-ncurses.git
    cd ffi-ncurses
    gem build ffi-ncurses.gemspec
    gem install ffi-ncurses-0.3.2.gem 

NOTE: I've asked the maintainer of ffi-ncurses to pull in the fix, but no answer on this ...

To run: (example script given life_ncurses_script)

    LifeNcurses.new(GameOfLife.new)

This will display the game of life in the terminal.

The visualization follows what is known as the Visitor Pattern (http://en.wikipedia.org/wiki/Visitor_pattern).  
You have one class, the visitor class, and another, a visitable class. When you initialize a visitor object, you give it as a parameter an object of the visitable class.  The visitor will call certain pre-defined methods (callback) on the visitable object.  In this case the visitor = the visualization, and the visitable = the game of life.  The callback is the 'evolve' method.  The output is displayed using curses.

NOTE: I have no computer under Windows, and ashbb confirmed that it doesn't work under Windows, ffi_ncurses doesn't seem to play nice with the dll. See next paragraph if you have a Windows computer.

## Shoes visualization ##
To solve the Windows issue, ashbb kindly provided a shoes visualization file - see life_shoes.rb.
Install shoes from [here](http://shoes.heroku.com/downloads).
You need to adapt life_shoes.rb in a couple of points (require your class, and call the initialization of your object in the Shoes.app).  To run, run Shoes, and open life_shoes.rb from the Shoes application.

# Bonus points #
* on readable implementation
* on elegant implementation
pure ruby, no gems.

# Out of contest brownie points #
if you implement another visualization for the game.  The ncurses one is text-based, you could do one in ruby-processing, Shoes, or another toolset of your choice.  As long as it takes the game of life object as a parameter at initialize, and calls 'evolve' on it, you can make many different visualizations - that's one of the advantages of the visitor pattern.

Credits to the Baltimore Ruby User Group for giving me the idea at Bohconf.
