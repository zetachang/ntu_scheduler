((function(){$(function(){return window.UIwrapper=function(){var a;return a=$("#content"),{refresh_options:{beforeSend:function(){return a.block(),$(".error_msg").html("")},success:function(b){return a=$("#content"),a.html(b)},error:function(){return $(".error_msg").html("← 出錯囉，點選logo回到我的課表"),$(".error_msg").fadeIn()},complete:function(){return a=$("#content"),a.unblock()}}}}(),$(".content_link").live("click",function(a){var b;return a.preventDefault(),b={type:$(this).attr("content-method")||"get"},$.ajax($(this).attr("href"),$.extend({},UIwrapper.refresh_options,b))}),$(".content_form").live("submit",function(a){return a.preventDefault(),$(this).ajaxSubmit(UIwrapper.refresh_options)})})})).call(this)