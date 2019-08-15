App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    if data.content?
      conversation = $('#conversations-list').find("[data-conversation-id='" + data.conversation + "']")
      conversation.find('.messages-list').find('ul').find('#messages').find('#messages-table').append '<div class="message">' +
        '<div class="message-received">' + data.content + '</div>' +
        '<div class="time-received">' + data.created_at + '</div>' + '</div>'
      $('.messages-list').scrollTop($('.messages-list')[0].scrollHeight)
