$(document).on("turbolinks:load", function() {
  $("#chat-sidebar").slimScroll({
    height: "100%",
    size: "6px"
  });

  $("#chat-body").slimScroll({
    height: "86%",
    size: "6px"
  });
});

$(document).on('turbolinks:load ajaxComplete', function() {
  $('.chat-room').unbind('click').on('click', function() {
    var chat_room_id = $(this).data('id');
    var chat_room_type = $(this).data('type');

    $('.chat-room').removeClass('active');
    $(this).addClass('active');

    $.get('/messages/new', {id: chat_room_id, type: chat_room_type});
  });
});
