$(document).on("turbolinks:load", function() {
  $("#chat-sidebar").slimScroll({
    height: "100%",
    size: "6px"
  });

  $("#chat-body").slimScroll({
    height: "75%",
    size: "6px"
  });

  $("#send-button").click(function() {
    var id = $(".active").data("id");
    var type = $(".active").data("type");
    var content = $("#chat-textarea").val();
    var message = {chat_room_id: id, chat_room_type: type, content: content}
    $.post("/messages", {message: message});
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
