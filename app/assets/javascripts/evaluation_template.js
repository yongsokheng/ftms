$(document).on("turbolinks:load", function() {
  var tbl_evaluation_template = $("#evaluation-template-tbl");
  if(tbl_evaluation_template.length > 0) {
    set_datatable(tbl_evaluation_template, [0, 2, 3, 4, 5]);
  }

  $('#evaluation_template_min_point').unbind('focus').on('focus', function () {
    $(this).attr('max', $('#evaluation_template_max_point').val());
  });
});
