$ ->
  # Have a concise interface to handle the share to faebook shit
  $('.fb_share').live "click", ->
    post_obj = $.parseJSON($(this).attr("data-obj"))
    FB.ui post_obj, ->
      # nothing