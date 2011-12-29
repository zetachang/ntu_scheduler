# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
    $('input, textarea').placeholder()
    $('#spinner').hide()
    $('form.new_user')
    .bind('ajax:before', ->
      $('#spinner').show()
      $('#creating_status').html("")
    )
    .bind('ajax:success', (xhr, data, status) ->
      if data.status == "SUCCESS"
        $('#creating_status').html("重導向，請稍候...")
        location.href = data.redirect_url
      else if data.status == "ERROR"
        if data.redirect_url
          $('#creating_status').html("重導向，請稍候...")
          location.href = data.redirect_url
        else
          $('#creating_status').html(data.message)
          $('#creating_status').hide()
          $('#creating_status').fadeIn()
    )
    .bind('ajax:error', ->
      $('#creating_status').html("發生未知錯誤，請重新整理網頁。")
    )
    .bind('ajax:complete', ->
      $('#spinner').hide()
    )
