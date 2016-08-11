$(document).on("turbolinks:load", function() {
  bind_for_loading_more_chat_room();
});

function bind_for_loading_more_chat_room () {
  if ($("#infinite-scrolling").size() > 0) {
    $("#chat-sidebar").bindWithDelay("scroll", function() {
      var more_posts_url;
      more_posts_url = $(".pagination .next a").attr("href");
      if (more_posts_url && $(this).scrollTop() > $(document).height() - $(window).height() - 60) {
        $(".loading").show();
        $.getScript(more_posts_url);
        return;
      }
    }, 500);
  }
}
