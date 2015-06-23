class StatefulFastclick extends window.FastClick
  # class variables / constants
  ###*
   * the class to be added when the element gets touched
   * @type {String}
  ###
  @TOUCHEDSTATECLASSNAME = 'fastclick-touched'
  ###*
   * the class to be added when the touched element becomes active
   * @type {String}
  ###
  @ACTIVESTATECLASSNAME  = 'fastclick-active'
  ###*
   * the name of the initial state
   * this constant is required for the changeState function of the FastClick object
   * @type {Number}
  ###
  @INITIALSTATE = 0
  ###*
   * the name of the touched state
   * this constant is required for the changeState function of the FastClick object
   * @type {Number}
  ###
  @TOUCHEDSTATE = 1
  ###*
   * the name of the active state
   * this constant is required for the changeState function of the FastClick object
   * @type {Number}
  ###
  @ACTIVESTATE = 2
  ###*
   * Constructor
   * @param  {DOMNode} layer  The dom node based on which to track clicks and apply states
   * @param  {Object} options supports the following options
   *                          - tapDelay: minimum time between touchstart and touchend to detect a tap / click
  ###
  constructor: (layer, options) ->
    # some adjustments to the default settings
    if !options
      options = {}
    options.tapDelay = 50
    super layer, options
    # the statelayer should be the layer, unless specified otherwise
    if !options.stateLayer
      options.stateLayer = layer
    @stateLayer = options.stateLayer

  ###*
   * changes the state of the touched / clicked element to the desired new state
   * available states are (constants):
   * - TOUCHEDSTATE (when an element is touched for the first time)
   * - ACTIVESTATE  (when an element is clicked, i.e. the touch ends a
   *
   * @param  {Number} newState  newState the desired new state as a numeric constant
  ###
  changeState: (newState) ->
    # get a reference to the currently touched (clicked) element
    # the element which should change its state is the stateLayer, not the touched element itself
    # as the touched element can be any arbitrary child node, but the states should be set consisently on the layer
    element = @stateLayer
    # remove all classes
    reset = () =>
      element.classList.remove @constructor.TOUCHEDSTATECLASSNAME
      element.classList.remove @constructor.ACTIVESTATECLASSNAME
    # set / reset classes depending on desired state
    switch newState
      when @constructor.TOUCHEDSTATE then element.classList.add @constructor.TOUCHEDSTATECLASSNAME
      when @constructor.ACTIVESTATE  then element.classList.add @constructor.ACTIVESTATECLASSNAME
      when @constructor.INITIALSTATE then do reset
      else do reset

  resetState: () ->
    # just call the changeState function without any parameters
    # this will switch the state to the initial one (INITIALSTATE)
    @changeState @constructor.INITIALSTATE

  onTouchStart: (event) ->
    # when touching starts and the method returns true, set the state to touched
    result = super event
    if result
      @changeState @constructor.TOUCHEDSTATE

  # Override relevant methods in FastClick to add state changes
  onTouchMove: (event) ->
    result = super event
    # we need to reset the state if trackingClick and targetElement have been unset
    if result and !@trackingClick and !@targetElement
      do @resetState

  onTouchEnd: (event) ->
    result = super event
    # we need to reset the state if the result is false and targetElement has been unset
    if !@targetElement and !result
      do @resetState

  onTouchCancel: (event) ->
    result = super event
    # on touch cancel we just always reset the state
    do @resetState

  onClick: (event) ->
    permitted = super event
    # when the click is not permitted or both trackingClick and targetElement have been unset,
    # we need to reset the state
    if !permitted or (!@trackingClick and !@targetElement)
      do @resetState

  sendClick: (targetElement, event) ->
    # when a click is sent by fastclick, we should set the state to be active
    @changeState @constructor.ACTIVESTATE
    super targetElement, event

root = exports ? window
root.StatefulFastclick = StatefulFastclick
