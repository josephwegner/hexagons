class @Tile
  constructor: (@game, x, y) ->
    @location = 
      x: (x * 75) + @game.canvas.center().left
      y: (y * yStepConstant * -1) + @game.canvas.center().top

  draw: ->
    cursorX = @location.x - 25
    cursorY = @location.y - 25

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

    @game.canvas.context.stroke()

  openNeighborCount: ->

  topNeighbor: ->
    @game.getTileAt @location.x + 2

