require 'game'
require 'ship'
require 'user_interface'

class TerminalIO
  def gets
    return Kernel.gets
  end

  def puts(message)
    Kernel.puts(message)
  end
end


RSpec.describe "Integration" do
  it "returns unplaced ships" do
    # The 5 ships are:  Carrier (occupies 5 spaces), Battleship (4), Cruiser (3), Submarine (3), and Destroyer (2).  
    ship_1 = Ship.new("Carrier",5)
    ship_2 = Ship.new("Battleship",4)
    ship_3 = Ship.new("Cruiser",3)
    ship_4 = Ship.new("Submarine",3)
    ship_5 = Ship.new("Destroyer",2)
    arr = [ship_1, ship_2, ship_3, ship_4, ship_5]
    game = Game.new("seb",10,10, arr)
    expect(game.unplaced_ships).to eq [ship_1, ship_2, ship_3, ship_4, ship_5]
    end

  it "places" do
    io = TerminalIO.new
    ship_1 = Ship.new("Carrier",5)
    ship_2 = Ship.new("Battleship",4)
    ship_3 = Ship.new("Cruiser",3)
    ship_4 = Ship.new("Submarine",3)
    ship_5 = Ship.new("Destroyer",2)
    arr = [ship_1, ship_2, ship_3, ship_4, ship_5]
    player1 = Game.new("seb",10,10, arr)
    player2 = Game.new("harith",10,10, arr)
    expect(io).to receive(:puts).with("seb has these ships remaining: 5, 4, 3, 3, 2")
    expect(io).to receive(:puts).with("Which do you wish to place?")
    expect(io).to receive(:gets).and_return("5\n")
    expect(io).to receive(:puts).with("Vertical or horizontal? [vh]")
    expect(io).to receive(:gets).and_return("v\n")
    expect(io).to receive(:puts).with("Which row?")
    expect(io).to receive(:gets).and_return("1\n")
    expect(io).to receive(:puts).with("Which column?")
    expect(io).to receive(:gets).and_return("1\n")
    expect(io).to receive(:puts).with("OK.")
    expect(io).to receive(:puts).with("This is your board now:")
    expect(io).to receive(:puts).with("S.........\nS.........\nS.........\nS.........\nS.........\n..........\n..........\n..........\n..........\n..........")
    user_interface = UserInterface.new(io, player1, player2)
    user_interface.place_ship_on_board(player1)
  end 

  it "places and doesn't allow ships to overlap" do
    io = TerminalIO.new
    ship_1 = Ship.new("Carrier",5)
    ship_2 = Ship.new("Battleship",4)
    ship_3 = Ship.new("Cruiser",3)
    ship_4 = Ship.new("Submarine",3)
    ship_5 = Ship.new("Destroyer",2)
    arr = [ship_1, ship_2, ship_3, ship_4, ship_5]
    player1 = Game.new("seb",10,10, arr)
    player2 = Game.new("harith",10,10, arr)
    expect(io).to receive(:puts).with("seb has these ships remaining: 5, 4, 3, 3, 2")
    expect(io).to receive(:puts).with("Which do you wish to place?")
    expect(io).to receive(:gets).and_return("5\n")
    expect(io).to receive(:puts).with("Vertical or horizontal? [vh]")
    expect(io).to receive(:gets).and_return("v\n")
    expect(io).to receive(:puts).with("Which row?")
    expect(io).to receive(:gets).and_return("1\n")
    expect(io).to receive(:puts).with("Which column?")
    expect(io).to receive(:gets).and_return("1\n")
    expect(io).to receive(:puts).with("OK.")
    expect(io).to receive(:puts).with("This is your board now:")
    expect(io).to receive(:puts)
    .with("S.........\nS.........\nS.........\nS.........\nS.........\n..........\n..........\n..........\n..........\n..........")
    #"S........."
    #"S........."
    #"S........."
    #"S........."
    #"S........."
    #".........."
    #".........."
    #".........."
    #".........."
    #".........."
    expect(io).to receive(:puts).with("seb has these ships remaining: 4, 3, 3, 2")
    expect(io).to receive(:puts).with("Which do you wish to place?")
    expect(io).to receive(:gets).and_return("4\n")
    expect(io).to receive(:puts).with("Vertical or horizontal? [vh]")
    expect(io).to receive(:gets).and_return("v\n")
    expect(io).to receive(:puts).with("Which row?")
    expect(io).to receive(:gets).and_return("1\n")
    expect(io).to receive(:puts).with("Which column?")
    expect(io).to receive(:gets).and_return("1\n")
    #"S........." FAILS (SHIP ALREADY EXISTS)
    #"S........."
    #"S........."
    #"S........."
    #".........."
    #".........."
    #".........."
    #".........."
    #".........."
    #".........."
    expect(io).to receive(:puts).with("Invalid Input, Try Again")
    p "Invalid passed"
    expect(io).to receive(:puts).with("Which do you wish to place?")
    expect(io).to receive(:gets).and_return("4\n")
    expect(io).to receive(:puts).with("Vertical or horizontal? [vh]")
    expect(io).to receive(:gets).and_return("v\n")
    expect(io).to receive(:puts).with("Which row?")
    expect(io).to receive(:gets).and_return("1\n")
    expect(io).to receive(:puts).with("Which column?")
    expect(io).to receive(:gets).and_return("2\n")
    expect(io).to receive(:puts).with("OK.")
    expect(io).to receive(:puts).with("This is your board now:")
    expect(io).to receive(:puts).with("SS........\nSS........\nSS........\nSS........\nS.........\n..........\n..........\n..........\n..........\n..........")
    #"SS........"
    #"SS........"
    #"SS........"
    #"SS........"
    #"S........."
    #".........."
    #".........."
    #".........."
    #".........."
    #".........."
    user_interface = UserInterface.new(io, player1, player2)
    user_interface.place_ship_on_board(player1)
    user_interface.place_ship_on_board(player1)
  end 

  it "doesn't allow ships to be placed unless they exist" do
    io = TerminalIO.new
    ship_1 = Ship.new("Carrier",5)
    ship_2 = Ship.new("Battleship",4)
    ship_3 = Ship.new("Cruiser",3)
    ship_4 = Ship.new("Submarine",3)
    ship_5 = Ship.new("Destroyer",2)
    arr = [ship_1, ship_2, ship_3, ship_4, ship_5]
    player1 = Game.new("seb",10,10, arr)
    player2 = Game.new("harith",10,10, arr)
    expect(io).to receive(:puts).with("seb has these ships remaining: 5, 4, 3, 3, 2")
    expect(io).to receive(:puts).with("Which do you wish to place?")
    expect(io).to receive(:gets).and_return("6\n") # LENGTH 6 DOESN'T EXIST (RE-PROMPT)
    expect(io).to receive(:puts).with("Vertical or horizontal? [vh]")
    expect(io).to receive(:gets).and_return("v")
    expect(io).to receive(:puts).with("Which row?")
    expect(io).to receive(:gets).and_return("1")
    expect(io).to receive(:puts).with("Which column?")
    expect(io).to receive(:gets).and_return("1")
    expect(io).to receive(:puts).with("Invalid Input, Try Again")
    expect(io).to receive(:puts).with("Which do you wish to place?")
    expect(io).to receive(:gets).and_return("5\n")
    expect(io).to receive(:puts).with("Vertical or horizontal? [vh]")
    expect(io).to receive(:gets).and_return("v\n")
    expect(io).to receive(:puts).with("Which row?")
    expect(io).to receive(:gets).and_return("1\n")
    expect(io).to receive(:puts).with("Which column?")
    expect(io).to receive(:gets).and_return("1\n")
    expect(io).to receive(:puts).with("OK.")

    expect(io).to receive(:puts).with("This is your board now:")
    expect(io).to receive(:puts).with("S.........\nS.........\nS.........\nS.........\nS.........\n..........\n..........\n..........\n..........\n..........")
    #"S........."   A SHIP OF LENGTH 5
    #"S........."
    #"S........."
    #"S........."
    #"S........."
    #".........."
    #".........."
    #".........."
    #".........."
    #".........."
    user_interface = UserInterface.new(io, player1, player1)
    user_interface.place_ship_on_board(player1)
  end 
  
  it "pushes the coords to hit array when a ship has been hit" do

    io = TerminalIO.new
    ship_1 = Ship.new("Carrier",5)
    arr = [ship_1]
    player1 = Game.new("seb",10,10, arr)
    player2 = Game.new("harith",10,10, arr)

    player1.coords = [[1,1],[1,2],[1,3][1,4]] #Set up player's board
    user_interface = UserInterface.new(io, player1, player2)

    expect(io).to receive(:puts).with("harith these are your hits and misses so far:")
    expect(io).to receive(:puts).with("..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........")
    expect(io).to receive(:puts).with("harith please select a position to fire at")
    expect(io).to receive(:puts).with("Which row?")
    expect(io).to receive(:gets).and_return("1")
    expect(io).to receive(:puts).with("Which column?")
    expect(io).to receive(:gets).and_return("1")

    expect(io).to receive(:puts).with("Hit!")

    user_interface.prompt_for_player(player2, player1)

    expect(player2.hit_array).to eq [[1,1]]
  end

  it "shows hits and misses so far for shooting player" do
    io = TerminalIO.new
    ship_1 = Ship.new("Carrier",5)
    arr = [ship_1]
    player1 = Game.new("seb",10,10, arr)
    player2 = Game.new("harith",10,10, arr)

    player1.hit_array = [[1,1],[1,2],[1,3],[1,4]] 
    player1.miss_array = [[2,1],[2,2],[2,3],[2,4]] 
    user_interface = UserInterface.new(io, player1, player2)

    expect(user_interface.format_shots(player1)).to eq "XO........\nXO........\nXO........\nXO........\n..........\n..........\n..........\n..........\n..........\n.........."
  end

  # TESTING WHILE LOOP IN RUN METHOD
  xit "game ends when player 1 destroys all player 2's ships" do
    io = TerminalIO.new
    ship_1 = Ship.new("Carrier",2)
    arr = [ship_1]
    player1 = Game.new("seb",10,10, arr)
    player2 = Game.new("harith",10,10, arr)

    interface = UserInterface.new(io, player1, player2)

    expect(io).to receive(:puts).with("seb has these ships remaining: 2")
    expect(io).to receive(:puts).with("Which do you wish to place?")
    expect(io).to receive(:gets).and_return("2\n")
    expect(io).to receive(:puts).with("Vertical or horizontal? [vh]")
    expect(io).to receive(:gets).and_return("h\n")
    expect(io).to receive(:puts).with("Which row?")
    expect(io).to receive(:gets).and_return("1\n")
    expect(io).to receive(:puts).with("Which column?")
    expect(io).to receive(:gets).and_return("1\n")
    expect(io).to receive(:puts).with("OK.")
    expect(io).to receive(:puts).with("This is your board now:")
    expect(io).to receive(:puts).with("S.........\nS.........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........")

    expect(io).to receive(:puts).with("harith has these ships remaining: 2")
    expect(io).to receive(:puts).with("Which do you wish to place?")
    expect(io).to receive(:gets).and_return("2\n")
    expect(io).to receive(:puts).with("Vertical or horizontal? [vh]")
    expect(io).to receive(:gets).and_return("h\n")
    expect(io).to receive(:puts).with("Which row?")
    expect(io).to receive(:gets).and_return("2\n")
    expect(io).to receive(:puts).with("Which column?")
    expect(io).to receive(:gets).and_return("2\n")
    expect(io).to receive(:puts).with(".S........\n.S........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........")

    expect(io).to receive(:puts).with("seb these are your hits and misses so far:")
    expect(io).to receive(:puts).with("..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........\n..........")
    expect(io).to receive(:puts).with("harith please select a position to fire at")
    expect(io).to receive(:puts).with("Which row?")
    expect(io).to receive(:gets).and_return("1")
    expect(io).to receive(:puts).with("Which column?")
    expect(io).to receive(:gets).and_return("1")
  end
end