$ ->

  $('.score_block .num')
  countdownNum = (num) ->
    $('.compare_info i').html("配對中……")
    counter = 0
    time_interval = num
    clock = (interval) ->
      setTimeout(->
        if counter < num
          if counter % 2 == 0
            if counter + 3 > num
              counter = num
            else
              counter += 3
          else
            if counter + 5 > num
              counter = num
            else
              counter += 5
          $('.score_block .num').html(counter)
          clock(interval*1.05)
        else
          $('.score_block .num').animate({"font-size": "110px"})
          $('.score_block .num').animate({"font-size": "90px"})
          $('.compare_info i').html("完成！")
      , interval)
    clock(time_interval)
  
  $content = $('#content')
  $('.compare_button a')
  .live("ajax:beforeSend", ->
    $content.block()
    $('.error_msg').hide()
    $('.error_msg').html("")
  )
  .live("ajax:success", (evt, data, status, xhr)->
    $content.html(data)
    countdownNum(parseInt($('.score_block .num').attr('match-score')))
  )
  .live("ajax:error", (evt, xhr, status, error)->
    $('.error_msg').html("← 出錯囉，點選logo回到我的課表")
    $('.error_msg').show()
    $('.error_msg').fadeIn()
  )
  .live("ajax:complete", ->
    $content.unblock()
  )
