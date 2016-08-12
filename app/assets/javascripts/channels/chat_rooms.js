App.global_chat = App.cable.subscriptions.create({
  channel: "ChatRoomsChannel"
}, {
  connected: function() {
  },

  disconnected: function() {
  },

  received: function(data) {
    $(".messages-list").append(data["message"]);
    $("#chat-body").slimScroll({scrollTo: $("#chat-body")[0].scrollHeight});
  }
});
