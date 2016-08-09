$(document).on('turbolinks:load', function() {
  if ($('#infinite-scrolling').size() > 0) {
    $('#chat-sidebar').bindWithDelay('scroll', function() {
      var more_posts_url;
      more_posts_url = $('.pagination .next a').attr('href');
      if (more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60) {
        $('.loading').show();
        $.getScript(more_posts_url);
        return;
      }
    }, 500);
  }
});
