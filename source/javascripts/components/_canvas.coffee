class @Canvas
  constructor: (@ele) ->
    @setSizing()
    @context = @ele.getContext "2d"

  setSizing: ->
    @ele.width = window.innerWidth
    @ele.height = window.innerHeight

  bounds: ->
    width: @ele.width
    height: @ele.height

  center: ->
    bounds = @bounds()

    left: bounds.width / 2
    top: bounds.height / 2
