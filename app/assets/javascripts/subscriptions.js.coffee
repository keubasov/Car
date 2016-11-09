# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
fill_types=(brand, type)->
    request = $.get '/subscriptions/select_type',
    brand: brand.val(),
    (data)->
      type.empty()
      type.append data

$(document).on "turbolinks:load",->
  $("#brand").change -> fill_types($("#brand"), $("#types"))
  if $("#content form").attr("class") != "edit_subscription" #edit action should save subscription's car type
    fill_types($("#brand"), $("#types"))
