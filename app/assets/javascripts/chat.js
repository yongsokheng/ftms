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
