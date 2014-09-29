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
      error: ->
        alert "Sorry, something went wrong with your search."
      complete: (result) ->
        button.prop('disabled', false).val("Find A Buddy")
    return
  return

loop_events = (events) ->
  i = 0
  points = []
  description = []
  $("#search-results").html("")
  while i < events.length
    points.push([events[i].title, events[i].latitude, events[i].longitude])
    description.push(['<div class="info_content">
          <h3><a href="/events/' + events[i].id + '">' + events[i].title + '</a></h3>
          <p>' + events[i].description + '</p>
          <p>' + events[i].start_time + '</p>
          </div>'])
    i++
  if events.length == 0
    $("#map_wrapper").addClass("hidden")
    $("#search-results").append("No Results Found.")
  else
    $("#map_wrapper").removeClass("hidden")
    initialize(points, description)
  return