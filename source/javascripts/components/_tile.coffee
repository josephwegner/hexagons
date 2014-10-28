class @Tile
  constructor: (@game, x, y) ->
    @location = 
      x: x
      y: y

    @color = []
    for i in [0..2]
      @color.push Math.floor(Math.random() * 255)

  draw: ->
    cursorX = ((@location.x * 75) + @game.canvas.center().left) - 25
    cursorY = ((@location.y * yStepConstant * -1) + @game.canvas.center().top) + 25

    @game.canvas.context.fillStyle = "rgba(#{@color[0]}, #{@color[1]}, #{@color[2]}, .75)"
    @game.canvas.context.strokeStyle = "rgba(#{@color[0]}, #{@color[1]}, #{@color[2]}, 1)"
    @game.canvas.context.lineWidth = 2

    # Set intial pen position
    @game.canvas.context.beginPath()
    @game.canvas.context.moveTo cursorX, cursorY

    # Base Line
    cursorX += 50
    @game.canvas.context.lineTo cursorX, cursorY

    cursorX += 25
    cursorY -= yStepConstant
    @game.canvas.context.lineTo cursorX, cursorY

    cursorX -= 25
    cursorY -= yStepConstant
    @game.canvas.context.lineTo cursorX, cursorY

    cursorX -= 50
    @game.canvas.context.lineTo cursorX, cursorY

    cursorX -= 25
    cursorY += yStepConstant
    @game.canvas.context.lineTo cursorX, cursorY

    cursorX += 25
    cursorY += yStepConstant
    @game.canvas.context.lineTo cursorX, cursorY

    @game.canvas.context.closePath()

    @game.canvas.context.stroke()
    @game.canvas.context.fill()

  getOpenNeighbor: ->
    openNeighbors = []
    openNeighbors.push [@location.x, @location.y + 2] if !@topNeighbor()
    openNeighbors.push [@location.x + 1, @location.y + 1] if !@topRightNeighbor()
    openNeighbors.push [@location.x - 1, @location.y + 1] if !@topLeftNeighbor()
    openNeighbors.push [@location.x - 1, @location.y - 1] if !@bottomLeftNeighbor()
    openNeighbors.push [@location.x, @location.y - 2] if !@bottomNeighbor()
    openNeighbors.push [@location.x + 1, @location.y - 1] if !@bottomRightNeighbor()

    openNeighbors[Math.floor(Math.random() * openNeighbors.length)]

  getNeighbors: ->
    topNeighbor = @topNeighbor()
    topRightNeighbor = @topRightNeighbor()
    topLeftNeighbor = @topLeftNeighbor()
    bottomNeighbor = @bottomNeighbor()
    bottomLeftNeighbor = @bottomLeftNeighbor()
    bottomRightNeighbor = @bottomRightNeighbor()

    neighbors = []
    neighbors.push(topNeighbor) if topNeighbor
    neighbors.push(topLeftNeighbor) if topLeftNeighbor
    neighbors.push(topRightNeighbor) if topRightNeighbor
    neighbors.push(bottomNeighbor) if bottomNeighbor
    neighbors.push(bottomLeftNeighbor) if bottomLeftNeighbor
    neighbors.push(bottomRightNeighbor) if bottomRightNeighbor

    neighbors

  openNeighborCount: ->
    count = 0
    count++ if !@topNeighbor()?
    count++ if !@topRightNeighbor()?
    count++ if !@topLeftNeighbor()?
    count++ if !@bottomNeighbor()?
    count++ if !@bottomLeftNeighbor()?
    count++ if !@bottomRightNeighbor()?

    count

  topNeighbor: ->
    @game.getTileAt @location.x, @location.y + 2

  topRightNeighbor: ->
    @game.getTileAt @location.x + 1, @location.y + 1

  topLeftNeighbor: ->
    @game.getTileAt @location.x - 1, @location.y + 1

  bottomNeighbor: ->
    @game.getTileAt @location.x, @location.y - 2

  bottomRightNeighbor: ->
    @game.getTileAt @location.x + 1, @location.y - 1

  bottomLeftNeighbor: ->
    @game.getTileAt @location.x - 1, @location.y - 1

