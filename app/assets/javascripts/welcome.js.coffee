# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
    $('form.new_user').bind('ajax:success', (xhr, data, status) ->
        if data.status == "SUCCESS"
            location.href = "/main"
    )
