$ ->
  #FIXME: the UI should be rewritten
  disableFormElements = (form) ->
    form.find('input, button, textarea, a').each ->
      $(this).prop("disabled", true)

  enableFormElements = (form) ->
    form.find('input, button, textarea, a').each ->
      $(this).prop("disabled", false)

  resetMessage = ->
    $('#result').empty()
    $('.interaction').empty()

  sendFbRequest = (friend_id) ->
    FB.ui({
      method: 'apprequests',
      message: '請問你什麼時候有空堂？',
      to: friend_id
    }, resetMessage)

  $('#suggest_form').append('<input type="hidden" name="fb_uid">')
  disableFormElements $('#suggest_form')
  if $('#fb_suggest').length > 0
    $.get "/main/friends", (data) ->
      friends = data
      enableFormElements $('#suggest_form')
      $('#fb_suggest').autocomplete
        source: friends
        select: (evt,ui) ->
          $('input[name="fb_uid"]').attr("value", ui.item.id)

    $('#suggest_form').live("ajax:before", ->
      resetMessage
    ).live("ajax:beforeSend", ->
      disableFormElements $(this).closest('form')
    ).live("ajax:success",(evt, data, status, xhr)->
      $('#result').html(xhr.responseText)
    ).live("ajax:error",(evt, xhr, status, error)->
      $('.interaction').append(xhr.responseText)
      $('#send_invitation').click ->
        sendFbRequest($('input[name="fb_uid"]')[0].value)
    ).live("ajax:complete",(evt, xhr, status)->
      $('#result').hide()
      $('#result').fadeIn()
      $('input[name="name"]').attr("value","")
      enableFormElements $(this).closest('form')
    )
    
