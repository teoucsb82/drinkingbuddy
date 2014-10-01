$(document).ready ->
  $("#verify-link").click ->
    $("#verification-form").slideToggle()
    return

  $("#btn-verify").submit (e) ->
    e.preventDefault()
    check_field($("#num-prefix"), 3)
    check_field($("#num-suffix"), 4)
    return false unless check_field($("#num-area_code"), 3) && check_field($("#num-prefix"), 3) && check_field($("#num-suffix"), 4)
    button = $(this).find(".btn")
    button.prop('disabled', true).val("Sending Message...")
    $.ajax
      url: '/twilio/send_text_message'
      type: 'POST'  
      data:
        number_to_send_to: $("#num-area_code").val() + $("#num-prefix").val() + $("#num-suffix").val()
      complete: ->
        $("#verification-form").hide()
    return
  return

check_field = (field, length) ->
  if field.val() == "" || field.val().length != length
    field.addClass("alert-danger");
    return false
  else
    field.removeClass("alert-danger") if field.hasClass("alert-danger")
    return true
  return