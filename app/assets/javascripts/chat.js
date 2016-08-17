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
    var room = $("#chat-sidebar .active-room");
    var content = $("#chat-textarea");
    var message = {chat_room_id: room.data("id"), chat_room_type: room.data("type"),
      content: content.val()}
    $.post("/messages", {message: message});
    content.val("");
  });

  $(".search-chat-room").on("keyup", function() {
    if (this.value.trim() !== "") {
      $("#users").html("");
      bind_for_loading_more_chat_room();
      $.getScript("/chats?q=" + this.value);
    }
  });
});

$(document).on("turbolinks:load ajaxComplete", function() {
  $(".chat-room").unbind("click").on("click", function() {
    var chat_room_id = $(this).data("id");
    var chat_room_type = $(this).data("type");

    $(".chat-room").removeClass("active-room");
    $(this).addClass("active-room");

    $.get("/messages/new", {id: chat_room_id, type: chat_room_type});
  });

  $("#chat-content .button-edit").unbind("click").on("click", function() {
    var id = $(this).data("id");
    var content = $.trim($("#message-" + id + " .chat-content").text());
    $(".message-content").removeClass("edit-message");
    $("#message-" + id).addClass("edit-message");
    $("#button-save").data("message-id", id)
    $("#chat-textarea").val(content);
    reset_button();
  });

  $("#chat-content #button-save").unbind("click").on("click", function() {
    var content = $("#chat-textarea").val();
    var message_id = $("#button-save").data("message-id");
    $.ajax({
      type: "PUT",
      data: {message: {content: content}},
      url: "/messages/" + message_id
    });
    reset_text();
  });

  $("#chat-content #cancel-button").unbind("click").on("click", function() {
    reset_text();
  });

  function reset_text() {
    $(".message-content").removeClass("edit-message");
    $("#chat-textarea").val("");
    $("#send-button").show();
    $("#cancel-button, #button-save").hide();
  }

  function reset_button() {
    $("#send-button").hide();
    $("#cancel-button, #button-save").show();
  }
});
