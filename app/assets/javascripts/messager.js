(function() {
  $(document).on('click', '.toggle-window', function(e) {
    e.preventDefault();
    var panel = $(this).parent().parent();
    var messages_list = panel.find('.messages-list');

    panel.find('.panel-body').toggle();
    panel.attr('class', 'panel panel-default');

    if (panel.find('.panel-body').is(':visible')) {
      var height = messages_list[0].scrollHeight;
      messages_list.scrollTop(height);
    }
  });

  $(document).on('keydown', function(event) {
    if(event.keyCode == 13 && !event.shiftKey){
      $('input').click();
      event.target.value = "";
      event.preventDefault();
    }
  });

  $(document).on('click', '.messages-list', function(e) {
    e.preventDefault();
    var user_id = $('.messages-list').attr('user-id');
    $('#message-panel').find("[user-id='" + user_id + "']").empty();
    $('#message-panel').find("[user-id='" + user_id + "']").append('<span class="badge badge-secondary" style="background-color: #FF0000;" value="0"></span>');
  });
})();
