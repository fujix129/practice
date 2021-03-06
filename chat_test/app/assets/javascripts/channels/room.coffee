App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#messages').append data['message']
    # Called when there's incoming data on the websocket for this channel

  send_message: (message) ->
    @perform 'send_message', message: message

jQuery(document).on 'keypress', '[data-behavior~=message_sender]', (event) ->
  if event.keyCode is 13
    App.room.send_message event.target.value
    event.target.value = ''
    event.preventDefault()
