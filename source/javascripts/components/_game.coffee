class @Game
  constructor: ->
    @canvas = new Canvas(document.getElementById("canvas"))

    tiles = [
      new Tile(this, 0, 0)

      new Tile(this, 1, 1)
      new Tile(this, 0, 2)
      new Tile(this, -1, 1)
      new Tile(this, -1, -1)
      new Tile(this, 0, -2)
      new Tile(this, 1, -1)
    ]
   
    tile.draw() for tile in tiles
