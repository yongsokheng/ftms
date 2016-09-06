$(document).on("turbolinks:load ajaxComplete", function() {
  $('.modal-form').on('hidden.bs.modal', function() {
    $(this).find("form")[0].reset();
  });
});
