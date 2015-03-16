rootDomain = window.location.origin
bars = []
NUM_BARS = 4
elem = document.getElementById("pingr")
num_requests = 0
currNumBars = 4
disconnectFnctn = undefined
reconnectFnctn = undefined
disconnected = false


clearChildren = () ->
  while (elem.firstChild)
    elem.removeChild(elem.firstChild)

changeNumBars = (numBars) ->
  return if numBars < 0 || numBars > NUM_BARS

  console.log "changing numBars to: "+numBars

  if numBars > currNumBars
    # show more bars
    for i in [currNumBars+1..numBars] by 1
      bars[i-1].style.display = "inline-block"
  else if numBars < currNumBars
    # hide more bars
    for i in [numBars+1..currNumBars] by 1
      bars[i-1].style.display = "none"
  else
    # numBars == currNumBars
    return

  currNumBars = numBars

initElement = (width, height) ->
  clearChildren()

  elem.style['border-radius'] = "5px"
  elem.style.border = "1px solid #9E9E9E"
  elem.style.width = width+"px"
  elem.style.height = height+"px"

  margin = 2

  if width < 50
    margin = 1

  barWidth = (width - ((NUM_BARS*2)*margin)) / 4
  barHeightIncrement = (height - ((NUM_BARS*2)*margin)) / 4

  for i in [1..NUM_BARS] by 1
    tempDiv = document.createElement("div")
    tempDiv.style['background-color'] = "#4CAF50"
    tempDiv.style.width = barWidth+"px"
    tempDiv.style.height = (i*barHeightIncrement)+"px"
    tempDiv.style.display = "inline-block"
    tempDiv.style.margin = margin+"px"
    tempDiv.style['margin-top'] = (height-(i*barHeightIncrement))+"px"
    bars[i-1] = elem.appendChild tempDiv


updatePing = (pingTime) ->

  console.log "ping time is: "+pingTime

  if pingTime == -1
    # internet is down
    disconnectFnctn() if disconnectFnctn?
    disconnected = true
    changeNumBars 0
  else
    if disconnected
      reconnectFnctn() if reconnectFnctn?
      disconnected = false

    if pingTime > 0 && pingTime <= 150
      changeNumBars 4
    else if pingTime > 150 && pingTime <= 300
      changeNumBars 3
    else if pingTime > 300 && pingTime <= 500
      changeNumBars 2
    else
      changeNumBars 1


pingServer = (callback) ->
  http = new XMLHttpRequest()
  url = rootDomain+"?cachebreaker="+Date.now()
  http.open "GET", url
  http.onreadystatechange = () ->
    if http.readyState == 4
      if http.status != 0
        # internet is not down
        ended = Date.now()
        pingTime = ended - started
        callback(pingTime)
      else
        # internet is down
        callback(-1)

  started = Date.now()
  http.send null
  num_requests++

Pingr = {}

Pingr.init = (width, height) ->
  rootDomain = window.location.origin
  bars = []
  NUM_BARS = 4
  elem = document.getElementById("pingr")
  num_requests = 0
  currNumBars = 4


  initElement(width, height)
  pingCallback = (pingTime) ->
    num_requests--
    updatePing pingTime
    if pingTime == -1
      # internet is down, lets check every 1000 ms
      setTimeout pingServer, 1000, pingCallback
    else
      setTimeout pingServer, 100, pingCallback
  pingServer pingCallback

Pingr.disconnectListener = (callback) ->
  disconnectFnctn = callback

Pingr.reconnectListener = (callback) ->
  reconnectFnctn = callback


window.Pingr = Pingr

