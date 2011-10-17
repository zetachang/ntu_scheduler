$ ->
  if $('#fb_suggest').length > 0
    $.get "/main/friends", (data) ->
      friends = data
      $('#fb_suggest').autocomplete
        source: friends
    
    $('#suggest_form').live("ajax:before", ->
      $('#result').css(opacity: 0.5)
      console.log "Great"
    ).live("ajax:success",(evt, xhr, data, status)->
    
    ).live("ajax:error",(evt, xhr, status, error)->
    
    ).live("ajax:complete",(evt, xhr, status)->
    
    )
    