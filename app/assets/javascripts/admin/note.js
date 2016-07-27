$(document).on("turbolinks:load", function() {
  $('#new-note-modal, #edit-note-modal').on('hidden.bs.modal', function () {
    $('#note_name').val('');
  });
});

$(document).on("turbolinks:load ajaxComplete", function(){
  $('.note').hover(function() {
    $(this).find('.action').show();
  },function() {
    $(this).find('.action').hide();
  });
});
