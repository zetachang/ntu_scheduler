$ ->
  $('a[href="#schedule_set"]').click(->
    $.ajax(
      url : "/schedule_sets"
      beforeSend: ->
        $('#schedule_set').animate opacity:0.5
      success: (data) ->
        $('#schedule_set').html(data)
      complete: ->
        $('#schedule_set').animate opacity:1.0
    )
  )
