$ ->

  # Reload the whole content container
  $('.content_link').live('click', (e) ->
    e.preventDefault()
    $content = $('#content')
    $content.block()
    $.get($(this).attr("href"), (data) ->
      console.log(data)
      $content.unblock()
      #$content.html(data)
    ).error ->
      #TODO: error handler
  )

