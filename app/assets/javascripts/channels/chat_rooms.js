App.global_chat = App.cable.subscriptions.create({
  channel: "ChatRoomsChannel"
}, {
  connected: function() {
  },

  disconnected: function() {
  },

  received: function(data) {
    message_list = $(".messages-list");
    message = message_list.find("#message-" + data["id"]);
    if (message.length == 0) {
      message_list.append(data["message"]);
    } else {
      message.replaceWith(data["message"]);
    }
    $("#chat-body").slimScroll({scrollTo: $("#chat-body")[0].scrollHeight});
  }
});
