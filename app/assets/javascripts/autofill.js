$(function() {
  return $('#post_book_name').autocomplete({
    source: $('#post_book_name').data('autocomplete-source'),
    select: function(event, ui) {
      event.preventDefault();
      $(this).val(ui.item.label);
      $('#book_id').val(ui.item.value);
    }
  });
});
