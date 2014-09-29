# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("#events_search").submit (e) ->
    e.preventDefault()
    if $("#address").val() == ""
      $("#address").addClass("alert-danger");
      return false
    else
      $("#address").removeClass("alert-danger") if $("#address").hasClass("alert-danger")
    button = $(this).find(".btn")
    button.prop('disabled', true).val("Searching...")
    $.ajax
      url: 'events/search'
      type: 'POST'  
      data:
        address: $("#address").val()
        radius: $("#radius").val()
        start_date: $("#start_date").val()
        hour: $("#event_start_time_4i").val()
        min: $("#event_start_time_5i").val()
      success: (data) ->
        events = $.parseJSON(data)
        loop_events(events)
      error: (result) ->
        console.log "2"
        alert("Sorry, we couldn't send your message.")    
      complete: (result) ->
        console.log "3"
        alert "done"
        button.prop('disabled', false).val("Find A Buddy")
    return
  return

loop_events = (events) ->
  i = 0
  $("#search-results").empty
  while i < events.length
    $("#search-results").append("<div class=\"row\"><a href=\"events/" + events[i].id + "\">" + events[i].title + "</a></div>")
    i++
  return