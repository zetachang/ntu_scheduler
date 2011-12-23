$ ->
  $('#send_invitation').live('click', ->
    friend_id = $(this).attr('friend-uid')
    console.log(friend_id)
    FB.ui(
      method: 'apprequests',
      message: '請問你什麼時候有空堂？',
      to: friend_id
    )
  )


