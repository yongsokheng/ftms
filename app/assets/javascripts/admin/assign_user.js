$(document).on("turbolinks:load", function() {
  $("#tbl-assign-user").DataTable({
    "dom": "<'row'<'col-sm-12'f>>" + "<'row'<'col-sm-12'tr>>",
    retrieve: true,
    "scrollY": "350px",
    "scrollCollapse": true,
    "paging": false,
    order: [1, "asc"],
    "columnDefs": [{"orderable": false, "targets": 0}],
    language: {
      search: "_INPUT_",
      searchPlaceholder: I18n.t("datatables.search_name_email")
    }
  });

  $("#tbl-assign-user tr").on("click", function(event) {
    var assign_checkbox = $(this).find("input[type=checkbox]");
    assign_checkbox.prop("checked", !assign_checkbox.is(":checked"));
  });

  $("#tbl-assign-user tr input[type=checkbox]").on("click", function(event) {
    event.stopPropagation();
  });

});
