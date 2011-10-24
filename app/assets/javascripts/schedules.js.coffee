$ ->
  disableFormElements = (form) ->
    form.find('input, button, textarea, a').each ->
      $(this).prop("disabled", true)
  enableFormElements = (form) ->
    form.find('input, button, textarea, a').each ->
      $(this).prop("disabled", false)
  
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
      $('#result').empty()
      $('.interaction').empty()
      
    ).live("ajax:beforeSend", ->
      disableFormElements $(this).closest('form')
    ).live("ajax:success",(evt, data, status, xhr)->
      $('#result').html(xhr.responseText)
    ).live("ajax:error",(evt, xhr, status, error)->
      $('.interaction').append(xhr.responseText)
    ).live("ajax:complete",(evt, xhr, status)->
      $('#result').hide()
      $('#result').fadeIn()
      $('input[name="fb_uid"]').attr("value","")
      $('input[name="name"]').attr("value","")
      enableFormElements $(this).closest('form')
    )
    