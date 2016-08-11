$(document).on("turbolinks:load", function() {
  if ($("#infinite-scrolling").size() > 0) {
    bind_for_loading_more_chat_room();
    load_more_messages();
  }
});

function bind_for_loading_more_chat_room () {
  $("#chat-sidebar").unbind("slimscroll").bind("slimscroll", function(e, position) {
    var more_posts_url = $(".sidebar-menu .pagination .next a").attr("href");

    if (more_posts_url && position == "bottom") {
      $(".sidebar-menu .loading").show();
      $.getScript(more_posts_url);
      return;
    }
  });
}

function load_more_messages() {
  $("#chat-body").unbind("scroll").on("scroll", function() {
    var more_posts_url = $("#chat-content .pagination .next a").attr("href");

    if (more_posts_url && $(this).scrollTop() == 0) {
      $("#chat-content .loading").show();
      $.getScript(more_posts_url);
      return;
    }
  });
}
