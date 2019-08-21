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

      user = $('#message-panel').find("[user-id='" + data.user_id + "']")
      value = parseInt($('.badge').attr('value')) + 1
      user.find('span').remove()
      user.append '<span class="badge badge-secondary" style="background-color: #FF0000;">' + value + '</span>'
      user.find('span').attr("value", value)

