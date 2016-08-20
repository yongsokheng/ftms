$(document).on("turbolinks:load", function() {
  if($("#message-content").length > 0) {
    reset_scroll();

    $(window ).resize(function() {
      reset_scroll();
    });
  }

  function reset_scroll() {
    var window_height = window.innerHeight;
    var header_height = $(".main-header").height();
    var chat_area_height = $("#chat-formarea").height();
    var search_room_height = $("#search-chat-room input").height();
    var chat_body_scroll_height = window_height - header_height - chat_area_height - 15;

    $("#message-content").height(chat_body_scroll_height);

    $("#chat-sidebar").slimScroll({
      height: "100%",
      size: "6px"
    });

    $("#chat-body").slimScroll({
      height: "100%",
      size: "6px"
    });
  }

  function chat_submit() {
    var active_room_id = $("#chat-sidebar .active-room").data("id");
    var room_id = $(".chat-form").data("chat-room-id");
    var room_type = $(".chat-form").data("chat-room-type");
    var content = $("#chat-textarea");
    var message = {chat_room_id: room_id, chat_room_type: room_type,
      content: content.val()};

    $.post("/messages", {message: message, active_room_id: active_room_id});

    content.val("");
  }

  $("#send-button").click(chat_submit);

  $("#chat-textarea").unbind("keypress").on("keypress", function(e) {
    if(e.which == 13 && $("#chat-enter-send").is(":checked")) {
      chat_submit();
    }
  });

  $(".search-chat-room").bindWithDelay("keyup", function() {
    $("#course-rooms").html("");
    $("#users").html("");
    bind_for_loading_more_chat_room();
    $.getScript("/chats?q=" + this.value);
  }, 100);
});

$(document).on("turbolinks:load ajaxComplete", function() {
  hide_action();
  edit_message();
  delete_message();

  $(".chat-room").unbind("click").on("click", function() {
    var chat_room_id = $(this).data("id");
    var chat_room_type = $(this).data("type");

    $(".chat-room").removeClass("active-room");
    $(this).addClass("active-room");

    $(".messages-list").html("");
    $(".message-paginate").html("");

    $.get("/messages/new", {id: chat_room_id, type: chat_room_type});
  });

  $("#chat-content #button-save").unbind("click").on("click", function() {
    var content = $("#chat-textarea").val();
    var message_id = $("#button-save").data("message-id");
    var active_room_id = $("#chat-sidebar .active-room").data("id");
    $.ajax({
      type: "PUT",
      data: {message: {content: content}, active_room_id: active_room_id},
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
});

$(document).on("turbolinks:load", function() {
  $(".chat-room:first").click();
});

function hide_action() {
  $("#button-save").hide();
  $("#cancel-button").hide();
}

function reset_button() {
  $("#send-button").hide();
  $("#cancel-button, #button-save").show();
}

function edit_message() {
  $("#chat-content .button-edit").unbind("click").on("click", function() {
    var id = $(this).data("id");
    var content = $.trim($("#message-" + id + " .chat-content").text());
    $(".message-content").removeClass("edit-message");
    $("#message-" + id).addClass("edit-message");
    $("#button-save").data("message-id", id);
    $("#chat-textarea").val(content);
    reset_button();
  });
}

function delete_message() {
  $("#chat-content .btn-delete").unbind("click").on("click", function(e) {
    e.preventDefault();
    var active_room_id = $("#chat-sidebar .active-room").data("id");
    $(this).attr("href", $(this).attr("href") + "?active_room_id=" + active_room_id);
    $(this).submit();
  });
}
