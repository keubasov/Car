# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
fill_models=(make, model)->
    request = $.get '/subscriptions/select_model',
    make: make.val(),
    (data)->
      model.empty()
      model.append data

$(document).on "turbolinks:load",->
  $("#make").change -> fill_models($("#make"), $("#models"))
  if $("#content form").attr("class") != "edit_subscription" #edit action should save subscription's car model
    fill_models($("#make"), $("#models"))
