$ ->
  if $('#fb_suggest').length > 0
    console.log 'XD'
    $.get "/main/friends", (data) ->
      console.log data
      friends = data
      $('#fb_suggest').autocomplete
        source: friends