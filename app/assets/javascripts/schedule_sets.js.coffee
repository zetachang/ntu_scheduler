$ ->
  $('.small_profile').twipsy(
    placement:"left"
    live:true
  )

  $('.more-block').live "click", ->
    if $(this).data("more")
      $(this).data("more").modal("show")
    else
      $(this).data("more",$(this).siblings(".more-users"))
      $(this).data("more").modal("show")

  $('#show_set_link')
  .live("ajax:beforeSend", ->
    # hide and remove the current sets list
    $('#schedule_set').animate opacity:0.5
  )
  .live("ajax:success", (evt, data, status, xhr)->
    $('#schedule_set').html(data)
  )
  .live("ajax:error", (evt, xhr, status, error)->
    #TODO: show some error
  )
  .live("ajax:complete", ->
    $('#schedule_set').animate opacity:1
  )
  
  $('#back_to_list_link')
  .live("ajax:beforeSend", ->
    # hide and remove the current sets list
    $('#schedule_set').animate opacity:0.5
  )
  .live("ajax:success", (evt, data, status, xhr)->
    $('#schedule_set').html(data)
  )
  .live("ajax:error", (evt, xhr, status, error)->
    #TODO: show some error
  )
  .live("ajax:complete", ->
    $('#schedule_set').animate opacity:1
  )
