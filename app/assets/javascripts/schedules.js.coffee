$ ->
    $('table td').hover (->
        console.log $(this).html()
        if $(this).html() != ""
            $(this).addClass("hover")
            $(this).attr("data-original-title","Location")
            $(this).attr("data-content":'The popover plugin provides a simple interface for adding popovers to your application. It extends the bootstrap-twipsy.js plugin, 
            so be sure to grab that file as well when including popovers in your project!')
            $(this).popover({})
            $(this).popover("show")
    ),->
        $(this).removeClass("hover")