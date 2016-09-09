$(document).on('turbolinks:load', function() {

  $('.user-subject-collapse').on('hide.bs.collapse', function () {
    toggle_icon_class($(this));
  });

  $('.user-subject-collapse').on('show.bs.collapse', function () {
    toggle_icon_class($(this));
  });

  function toggle_icon_class(element) {
    element.parents('.timeline-item').find('.glyphicon')
      .toggleClass('glyphicon-chevron-down glyphicon-chevron-up');
  }
});
