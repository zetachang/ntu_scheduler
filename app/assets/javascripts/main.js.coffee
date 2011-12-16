$ ->

  # Reload the whole content container
  $('.content_link').live('click', (e) ->
    e.preventDefault()
    $content = $('#content_container')
    $content.html('')
    $content.append('<img src="/assets/spinner.gif"></img>')
    $.get($(this).attr("href"), (data) ->
      console.log(data)
      $('#content_container').html(data)
    ).error ->
      #TODO: error handler
  )

