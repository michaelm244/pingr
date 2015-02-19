rootDomain = window.location.origin
bars = []
NUM_BARS = 4
elem = document.getElementById("pingr")

hideBars = () ->
  for i in [1, NUM_BARS] by 1
    bars[i-1].style.display = "none"

changeNumBars = (numBars) ->
  hideBars()

  return if numBars <= 0 || numBars > NUM_BARS

  console.log "changing numBars to: "+numBars

  for i in [1, numBars] by 1
    bars[i-1].style.display = "inline-block"

initElement = ->
  textNode = document.createTextNode "Network Strength:"
  pTag = document.createElement "p"
  pTag.appendChild textNode

  elem.appendChild pTag

  max_height = NUM_BARS*20

  for i in [1..NUM_BARS] by 1
    tempDiv = document.createElement("div")
    tempDiv.style['background-color'] = "green"
    tempDiv.style.width = "20px"
    tempDiv.style.height = (i*20)+"px"
    tempDiv.style.display = "inline-block"
    tempDiv.style.margin = "5px"
    tempDiv.style['border-radius'] = "4px"
    tempDiv.style['margin-top'] = (max_height-(i*20))+"px"
    bars[i-1] = elem.appendChild tempDiv

updatePing = (pingTime) ->

  console.log "ping time is: "+pingTime

  if pingTime == -1
    # internet is down
    changeNumBars 0
  else
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

init = ->
  initElement()
  pingCallback = (pingTime) ->
    updatePing pingTime
    if pingTime == -1
      # internet is down, lets check every 1000 ms
      setTimeout pingServer(pingCallback), 1000
    else
      setTimeout pingServer(pingCallback), 500
  pingServer pingCallback


setTimeout init, 0

