$ ->
  show_success_block = ->
    $('#send_block').hide()
    $('#success_block').fadeIn()

  $('#send_invitation').live('click', ->
    friend_id = $(this).attr('friend-uid')
    FB.ui(
      method: 'apprequests',
      message: '請問你什麼時候有空堂？',
      to: friend_id
    , show_success_block)
  )


