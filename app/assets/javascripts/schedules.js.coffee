$ ->
  disableFormElements = (form) ->
    form.find('input, button, textarea, a').each ->
      $(this).prop("disabled", true)
  enableFormElements = (form) ->
    form.find('input, button, textarea, a').each ->
      $(this).prop("disabled", false)
    
  $('#suggest_form').append('<input type="hidden" name="fb_uid">')
  disableFormElements $('#suggest_form')
  
  $('#add_to_set_form')
  .live("ajax:success",(evt, data, status, xhr)->
    $button = $(this).find('input[type="submit"]')
    $button.data('twipsy', null).twipsy
      title: ->
        data.message
      trigger:"manual"
      placement: "above"
    $button.twipsy('show')
    setTimeout (-> $button.twipsy('hide')), 1400
  )
  .live("ajax:error",(evt, xhr, status, error)->
    $button = $(this).find('input[type="submit"]')
    $button.data('twipsy', null).twipsy
      title: ->
        "Error! Try later"
      trigger:"manual"
      placement: "above"
    $button.twipsy('show')
    setTimeout (-> $button.twipsy('hide')), 1400
  )

  

  $modal_block = $('#new_set')
  $modal_block.modal(backdrop:true)
  
  $('#add_to_set_select').change ->
    value = $(this).val()
    if value == "0"
      $modal_block.modal('show')
      $('#add_to_set_select').val("")
  
  $('#create_new_set_btn').click ->
    $('#create_new_set_form').submit()
    $modal_block.modal('hide')

  #Handle ajax empty set creation, using twipsy to indicate status message
  $('#create_new_set_form')
  .live("ajax:before", ->
    $('#add_to_set_select').animate opacity:0.5
    $('#add_to_set_select').prop("disabled", true)
  )
  .live("ajax:success", (evt, data, status, xhr)->
    $('#add_to_set_select').data('twipsy', null).twipsy
      title: ->
        "Success"
      trigger:"manual"
      placement: "left"
    $('#add_to_set_select').twipsy('show')
    setTimeout (-> $('#add_to_set_select').twipsy('hide')), 1400
    $("<option value=\"#{data.id}\">#{data.name}</option>").insertBefore('option[value="0"]')
  )
  .live("ajax:error", (evt, xhr, status, error)->
    $('#add_to_set_select').data('twipsy', null).twipsy
      title: ->
        "Error! Try later"
      trigger:"manual"
      placement: "left"
    $('#add_to_set_select').twipsy('show')
    setTimeout (-> $('#add_to_set_select').twipsy('hide') .data('twispy', null)), 1400
  )
  .live("ajax:complete", ->
    $('#add_to_set_select').animate opacity:1.0
    $('#add_to_set_select').prop("disabled", false)
  )
  
  #TODO #add_to_set_form handler
  
  #Searching friends' schedule field and autocomplete
  if $('#fb_suggest').length > 0
    # Get the friends list from server and populate invisible field
    $.get "/main/friends", (data) ->
      friends = data
      enableFormElements $('#suggest_form')
      $('#fb_suggest').autocomplete
        source: friends
        select: (evt,ui) ->
          $('input[name="fb_uid"]').attr("value", ui.item.id)
      # Overwrite render item function to insert small icon
      $('#fb_suggest').data('autocomplete')._renderItem = (ul, item) ->
        fb_profile = "http://graph.facebook.com/" + item.id + "/picture?type=square"
        $("<li></li>")
        .data("item.autocomplete", item)
        .append('<a>' + '<img src="' + fb_profile + '">' + "<div class='value'>" + item.value +  "</div>" + '</a>')
        .appendTo(ul)
      # Overwrite render menu function to limit the result
      $('#fb_suggest').data('autocomplete')._renderMenu = ( ul, items ) ->
        self = this
        $.each items, ( index, item ) ->
          if index < 10
            self._renderItem( ul, item )
    # Handle ajax form sending
    $('#suggest_form')
    .live("ajax:before", ->
      $('#result').empty()
      $('.interaction').empty()
    )
    .live("ajax:beforeSend", ->
      disableFormElements $(this).closest('form')
    )
    .live("ajax:success",(evt, data, status, xhr)->
      $('#result').html(xhr.responseText)
    )
    .live("ajax:error",(evt, xhr, status, error)->
      $('.interaction').append(xhr.responseText)  
    )
    .live("ajax:complete",(evt, xhr, status)->
      $('#result').hide()
      $('#result').fadeIn()
      $('input[name="fb_uid"]').attr("value","")
      $('input[name="name"]').attr("value","")
      enableFormElements $(this).closest('form')
    )
    
