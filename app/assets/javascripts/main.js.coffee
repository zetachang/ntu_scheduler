$ ->
  window.UIwrapper = (->
    $content = $('#content')

    # options make $.ajax refresh the #content
    refresh_options :
      beforeSend : ->
        $content.block()
        console.log($('#content'))
      success : (data) ->
        $content = $('#content')
        $content.html(data)
      error : ->
        #TODO: error handler
      complete : ->
        $content = $('#content')
        #$content.unblock()
  )()

  $('.content_link').live('click', (e) ->
    e.preventDefault()
    $.ajax($(this).attr('href'), UIwrapper.refresh_options)
  )
