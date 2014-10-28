class @Game
  constructor: ->
    @canvas = new Canvas(document.getElementById("canvas"))
    @truck = document.getElementById("truck")
    @truck.src = "/images/truckn.png"
    @allTiles = []
    @tilePositions = {}
    @openTiles = [[],[],[],[],[],[]]
    @fps = 60
    @drawInterval = 1000 / @fps

    @bindKeyEvents()

    @lastDraw = Date.now()

    @leftPressed = false
    @downPressed = false
    @rightPressed = false
    @leftPressed = false

    @calculateDirection()
    requestAnimationFrame(@renderLoop.bind(this));


  renderLoop: ->
    @canvas.context.clearRect(0, 0, @canvas.bounds().width, @canvas.bounds().height)

    timeDiff = Date.now() - @lastDraw

    if @direction
      @canvas.move @direction, timeDiff

    for tile in @allTiles
      tile.draw()

    requestAnimationFrame @renderLoop.bind(this)
    @lastDraw = Date.now()

  bindKeyEvents: ->
    @leftPressed = false
    @rightPressed = false
    @upPressed = false
    @downPressed = false

    document.addEventListener "keydown", (e) =>
      switch e.which
        when 40
          if !@downPressed
            @downPressed = true
            @calculateDirection()
        when 39
          if !@rightPressed
            @rightPressed = true
            @calculateDirection()
        when 38
          if !@upPressed
            @upPressed = true
            @calculateDirection()
        when 37
          if !@leftPressed
            @leftPressed = true
            @calculateDirection()

    document.addEventListener "keyup", (e) =>
      switch e.which
        when 40
          if @downPressed
            @downPressed = false
            @calculateDirection()
        when 39
          if @rightPressed
            @rightPressed = false
            @calculateDirection()
        when 38
          if @upPressed
            @upPressed = false
            @calculateDirection()
        when 37
          if @leftPressed
            @leftPressed = false
            @calculateDirection()

  calculateDirection: ->
    if @upPressed
      if @rightPressed
        @direction = "ne"
      else if @leftPressed
        @direction = "nw"
      else
        @direction = "n"
    else if @downPressed
      if @rightPressed
        @direction = "se"
      else if @leftPressed
        @direction = "sw"
      else
        @direction = "s"
    else if @leftPressed
      @direction = "w"
    else if @rightPressed
      @direction = "e"
    else
      @direction = false

    if @direction
      @truck.src ="/images/truck#{@direction}.png"

  generateRandomTile: ->
    # Ideally, the lower @openTileCounts won't have any values. If that's the case, don't include them in this calculation
    openTilesIndexes = []
    for openTiles, index in @openTiles
      openTilesIndexes.push index if @openTiles[index].length

    max = openTilesIndexes.length

    # The math here is essentially a random distribution along y=5x^3
    # where Y is the openTileCount
    # The Math.pow(max/5, 1/3) portion in there just makes sure that Y is never greater than oepnTileCounts.length
    # The point of doing it this way is so that we fill the smaller gaps first
    multiplier = 1000
    selectedOpenTileIndex = openTilesIndexes[Math.floor(multiplier * Math.pow(Math.random() * Math.pow(max/multiplier, 1/3), 3))]
    selectedOpenTileCount = @openTiles[selectedOpenTileIndex]

    # Grab the tile we want to use, randomly
    selectedTileIndex = Math.floor(Math.random() * selectedOpenTileCount.length)
    selectedTile = selectedOpenTileCount[selectedTileIndex]

    newTileLocation = selectedTile.getOpenNeighbor()
    newTile = new Tile(this, newTileLocation[0], newTileLocation[1])

    @addTile(newTile)

    neighbors = newTile.getNeighbors()
    for neighbor in neighbors
      openNeighbors = neighbor.openNeighborCount()

      for tile, index in @openTiles[openNeighbors]
        if tile.location.x == neighbor.location.x and tile.location.y == neighbor.location.y
          @openTiles[openNeighbors].splice index, 1
          break

      if openNeighbors > 0
        @openTiles[openNeighbors - 1].push neighbor

  addTile: (tile) ->
    @allTiles.push tile

    if !@tilePositions[tile.location.x]?
      @tilePositions[tile.location.x] = {}

    @tilePositions[tile.location.x][tile.location.y] = tile

    @openTiles[tile.openNeighborCount() - 1].push tile

  getTileAt: (x, y) ->
    if !@tilePositions[x]? or !@tilePositions[x][y]?
      return null

    @tilePositions[x][y]

