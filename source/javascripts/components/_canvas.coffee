class @Canvas
  constructor: (@ele) ->
    @setSizing()
    @context = @ele.getContext "2d"
    @xOffset = 0
    @yOffset = 0
    @stepLength = .2

  move: (direction, tElapsed) ->
    step = @stepLength * tElapsed
    switch direction
      when 'n'
        @yOffset += step
      when 's'
        @yOffset -= step
      when 'e'
        @xOffset -= step
      when 'w'
        @xOffset += step
      when 'nw'
        @xOffset += step / 2
        @yOffset += step / 2
      when 'ne'
        @xOffset -= step / 2
        @yOffset += step / 2
      when 'sw'
        @xOffset += step / 2
        @yOffset -= step / 2
      when 'se'
        @xOffset -= step / 2
        @yOffset -= step / 2
  
  setSizing: ->
    @ele.width = window.innerWidth
    @ele.height = window.innerHeight

  bounds: ->
    width: @ele.width
    height: @ele.height

  center: ->
    bounds = @bounds()

    left: (bounds.width / 2) + @xOffset
    top: (bounds.height / 2) + @yOffset
