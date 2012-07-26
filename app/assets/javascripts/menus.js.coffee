# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(($)->
  $('#update-time-link')
    .live("ajax:complete", (xhr)->
      $('#time').append('<div>Done.</div>')
    )
    .live("ajax:beforeSend", (xhr)->
      $('#time').append('<div>Loading...</div>')
    )
    .live("ajax:success", (event, data, status, xhr)->
      $('#time').append('<div>Yeah!</div>')
    )
    .live("ajax:error", (data, status, xhr)->
      alert("failure!!!")
    )
)