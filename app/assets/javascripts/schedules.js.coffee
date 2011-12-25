$ ->
  disableFormElements = (form) ->
    form.find('input, button, textarea, a').each ->
      $(this).prop("disabled", true)
  enableFormElements = (form) ->
    form.find('input, button, textarea, a').each ->
      $(this).prop("disabled", false)
    
  $('#suggest_form').append('<input type="hidden" name="fb_uid">')
  disableFormElements $('#suggest_form')

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
          $('#suggest_form').submit()

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

