rootDomain = window.location.origin
bars = []
NUM_BARS = 4
elem = document.getElementById("pingr")

changeNumBars = (numBars) ->


initElement = ->
  elem.style.display
  for i in [1..NUM_BARS] by 1
    tempDiv = document.createElement("div")
    tempDiv.style['background-color'] = 'green'
    tempDiv.style.width = '20px'
    tempDiv.style.height = (i*20)+"px"
    tempDiv.style.display = "inline-block"
    tempDiv.style.margin = "5px";
    bars[i-1] = elem.insertBefore tempDiv, null

updatePing = (pingTime) ->
  if pingTime == -1
    # internet is down
  else
    switch pingTime
      when pingTime > 0 && pingTime <= 150 then changeNumBars 4
      when pingTime > 150 && pingTime <= 300 then changeNumBars 3
      when pingTime > 300 && pingTime <= 500 then changeNumBars 2
      else changeNumBars 1




pingServer = (callback) ->
  started = Date.now()
  http = XMLHttpRequest()
  http.open "GET", rootDomain
  http.onreadystatechange = () ->
    if http.readyState == 4
      if http.status != 0
        # internet is not down
        ended = Date.now()
        pingTime = ended - started
      else
        # internet is down
      callback()


init = ->
  initElement();

setTimeout init, 0

