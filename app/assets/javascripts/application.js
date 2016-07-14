// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require i18n
//= require i18n/translations
//= require i18n.js
//= require bootstrap-sprockets
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.ja.js
//= require bootstrap-datepicker/locales/bootstrap-datepicker.en-GB.js
//= require ckeditor/init
//= require ckeditor/config
//= require datepicker
//= require highcharts
//= require highcharts/highcharts-more
//= require admin/role_permission
//= require admin/evaluation
//= require admin/note
//= require jquery-ui/sortable
//= require jquery-ui/effect-highlight
//= require admin/update_order_course_subject
//= require admin/user_progress_chart
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require jquery.dataTables.columnFilter
//= require subject
//= require course
//= require evaluation
//= require role
//= require profile
//= require evaluation_template
//= require rank
//= require university
//= require jquery.quicksearch
//= require reports
//= require user_subject

$(document).on("page:update", function() {
  $(".alert").delay(3000).slideUp();
  $("#error_explanation").delay(3000).slideUp();
});

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).parent().parent().hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}

$(document).on("page:change", function() {
  $(".ckeditor").each(function() {
    CKEDITOR.replace($(this).attr("id"));
  });

  $(".sidebar-toggle").click(function() {
    $("#body-admin").toggleClass("sidebar-collapse")
  });

  $(".treeview").click(function() {
    $(this).toggleClass("active");
    $(".treeview-menu").toggleClass("menu-open");
  });

  if ($(".evaluation-active").length > 0) {
    $("#evaluations-header").addClass("active");
  }

  if ($(".profile-active").length > 0) {
    $("#user-profiles-header").addClass("active");
  }
});

