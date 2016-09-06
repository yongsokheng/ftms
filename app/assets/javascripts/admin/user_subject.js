$(document).on('turbolinks:load ajaxComplete', function() {
  if($('#user-subject').length > 0 ) {
    $('.fa-edit').unbind('click').on('click', function() {
      var date = $(this).closest('td');
      date.find('.form-edit').show();
      date.find('.date-content').hide();
    });

    $('.fa-remove').unbind('click').on('click', function() {
      var date = $(this).closest('td');
      date.find('.form-edit').hide();
      date.find('.date-content').show();
    });
  };
});
