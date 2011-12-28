$ ->
  $('.error_msg').hide()
  window.UIwrapper = (->
    $content = $('#content')

    # options make $.ajax refresh the #content
    refresh_options :
      beforeSend : ->
        $('.twipsy').detach()
        $content.block()
        $('.error_msg').hide()
      success : (data) ->
        $content = $('#content')
        $content.html(data)
      error : ->
        $('.error_msg').html("← 出錯囉，點選logo回到我的課表")
        $('.error_msg').show()
        $('.error_msg').fadeIn()
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
