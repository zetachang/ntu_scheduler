window.Utility = {
  
  delay : (millisecs, func) ->
    setTimeout(func, millisecs)

  spinner : (width = 50, height = 50) ->
    spinner = $('<div>')
    spinner.css(
      'background' : 'url("assets/spinner.gif") no-repeat'
      'width' : width
      'height' : height
      'margin' : 'auto'
    )
}

$.extend(true, $.blockUI.defaults,
  message : Utility.spinner()
  css :
    border : ""
    backgroundColor : 'transparent'
  overlayCSS :
    backgroundColor : '#fff'
    opacity : 0.75
)


