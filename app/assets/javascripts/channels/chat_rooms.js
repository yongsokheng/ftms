App.global_chat = App.cable.subscriptions.create({
  channel: "ChatRoomsChannel"
}, {
  connected: function() {
  },

  disconnected: function() {
  },

  received: function(data) {
    var room = $(".chat-room[data-id='" + data["channel_id"] + "'][data-type='" + data["channel_type"] + "']");
    message_list = $(".messages-list");
    message = message_list.find("#message-" + data["message_id"]);

    if (message.length == 0) {
      if (room.hasClass("active-room")) {
        message_list.append(data["message"]);
        $.ajax({
          type: "PUT",
          url: "/read_marks/" + data["message_id"]
        });
      } else {
        $(".sidebar-menu").prepend(room);
        var new_message = room.find(".badge");
        var new_message_count = parseInt(new_message.text());
        if (isNaN(new_message_count)) {
          new_message_count = 0;
        }
        new_message_count ++;
        new_message.text(new_message_count);
      }
    } else {
      message.replaceWith(data["message"]);
    }

    edit_message();
    delete_message();

    message = message_list.find("#message-" + data["message_id"]);
    current_user = parseInt($("meta[name=current-user]").attr("id"));
    message_user = message.data("user-id");
    if (current_user != message_user) {
      message.find(".message-actions").remove();
    }

    $("#chat-body").slimScroll({scrollTo: $("#chat-body")[0].scrollHeight});
  }
});
