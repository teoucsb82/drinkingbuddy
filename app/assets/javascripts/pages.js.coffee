# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("#address").focus ->
    $("#address").removeClass("alert-danger") if $("#address").hasClass("alert-danger")
    return
    
  $("#options").click ->
    label = $(this)
    label.toggleClass("fa-arrow-up fa-arrow-down")
    $("#additional-options").toggleClass("hidden")
    if label.text() == "More Options"
      label.text("Less Options")
    else
      label.text("More Options")
    return
  return

