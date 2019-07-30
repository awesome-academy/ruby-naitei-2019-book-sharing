$(document).on('click', '.rate', function(){
  var score = $(this).index() + 1;
  var book_id = $('.current-book-id').attr('id');
  var user_id = $('.current-book-id').attr('user_id');
  console.log(score);
  $.ajax({
    beforeSend: function(xhr){
        xhr.setRequestHeader('X-CSRF-Token',
          $('meta[name="csrf-token"]').attr('content'));
      },
    type: 'POST',
    url: '/books/' + book_id + '/rates',
    data: {
      user_id: user_id,
      score: score,
      book_id: book_id
    },
    success: function() {
        $('#rate').load(document.URL + ' #rate');
      }
  });
});
