# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('form.new_user')
    .bind('ajax:success', (xhr, data, status) ->
      $('.error').html("")
            if data.status == "SUCCESS"
              location.href = "/main"
            else if data.status == "ERROR"
              $('.error').html(data.message)
    ).bind('ajax:error', ->
      $('.error').html("發生未知錯誤，請重新整理網頁。")
    )
