$ ->
  window.UIwrapper = (->
    $content = $('#content')

    # options make $.ajax refresh the #content
    refresh_options :
      beforeSend : ->
        $content.block()
      success : (data) ->
        $content = $('#content')
        $content.html(data)
      error : ->
        #TODO: error handler
      complete : ->
        $content = $('#content')
        $content.unblock()
  )()

  $('.content_link').live('click', (e) ->
    e.preventDefault()
    extra_options =
      type: $(this).attr('content-method') || 'get'
    $.ajax($(this).attr('href'), $.extend({}, UIwrapper.refresh_options, extra_options))
  )
  $('.content_form').live('submit', (e) ->
    e.preventDefault()
    $(this).ajaxSubmit(UIwrapper.refresh_options)
  )
