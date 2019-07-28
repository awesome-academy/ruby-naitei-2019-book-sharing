$(document).ready(function(){
  $('.best_in_place').best_in_place();
});

$(document).keypress(function(event){

  var keycode = (event.keyCode ? event.keyCode : event.which);
  if(keycode == '13'){
    $('#submitBtn').click();
  }
});

$(document).on('click', '.create-comment', function(event) {
  function locale() { return $('body').data('locale') }
  event.preventDefault();

  var userId = $('#user-id').val();
  var postId = $('#post-id').val();
  var content = $('.text-content').val();
  var url = '/posts/'+ postId + '/comments/';
  $.ajax({
    beforeSend: function (xhr) {
      xhr.setRequestHeader('X-CSRF-Token',
          $('meta[name="csrf-token"]').attr('content'));
    },
    type: 'POST',
    url: url,
    data: {
      comment: {
        content: content,
        post_id: postId,
        user_id: userId
      }
    },
    success: function (e) {
      $('.comment-count-' + postId).text(e.comments_count);
      $('#comments').load(document.URL + ' #comments');
      $('.text-content').val('')
    }
  });
});

$(document).on('click', '.delete-comment', function() {
  var commentId = $(this).attr('id');
  var postId = $(this).attr('value');
  var url = '/posts/' + postId + '/comments/' + commentId;

  $.ajax({
    beforeSend: function (xhr) {
      xhr.setRequestHeader('X-CSRF-Token',
          $('meta[name="csrf-token"]').attr('content'));
    },
    type:'DELETE',
    url: url,
    data: {
      comment: {
        id: commentId
      }
    },
    success: function(e) {
      $('.comment-count-' + postId).text(e.comments_count);
      $('#comments').load(document.URL + ' #comments');
    }
  });
});

// edit comment
$(document).on('click', '.edit-comment', function() {
  var comment_id = $(this).attr('id');
  var edit_comment = '.comment-item-' + comment_id;
  var edited_comment = '.edited-' + comment_id;
  var editMode = $(this).hasClass('edit-mode'),
      contents = $(edit_comment);

  if (!editMode){
    $(this).html('Save').addClass('edit-mode');
    contents.each(function(){
      var txt = $(this).text();
      var input = $('<textarea class="edit-content form-control">');
      input.val(txt);
      $(this).html(input);
    });

  } else {
    $(this).html('Edit').removeClass('edit-mode');
    contents.each(function(){
      var user_id = $('#user-id').val();
      var post_id = $('#post-id').val();
      var content = $(this).find('.edit-content').val();
      var url = '/posts/' + post_id + '/comments/' + comment_id;

      $.ajax({
        beforeSend: function (xhr) {
          xhr.setRequestHeader('X-CSRF-Token',
            $('meta[name="csrf-token"]').attr('content'));
        },
        type: 'PATCH',
        url: url,
        data: {
          comment: {
            id: comment_id,
            content: content,
            post_id: post_id,
            user_id: user_id
          }
        },
        success: function () {
          $('#comments').load(document.URL + ' #comments');
        }
      });
    });
  }
});
