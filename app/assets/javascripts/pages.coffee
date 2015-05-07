# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $('.datepicker').datepicker()
  $("#state").val("")

  $('#state').on 'change', ->
    state_id = $(this).val()
    $('#jury').find('option').remove().end()
    if state_id
      $.ajax '/jury',
        data: { state_id: state_id }
        type: 'GET'
        dataType: 'json'
        success: (data, textStatus, jqXHR) ->
          for option in data['options']
            $("#jury").append("<option value='"+option[1]+"'>"+option[0]+"</option>")

$(document).ready(ready)
$(document).on('page:load', ready)


