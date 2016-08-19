$(document).on('turbolinks:load', function() {
  var tbl_subject = $('#subjects');
  if(tbl_subject.length > 0) {
    set_datatable(tbl_subject, [0, 2]);
  }

  $('#user-subjects-charts').highcharts({
      chart: {
        type: 'column'
      },
      title: {
        text: I18n.t('user_subjects.chart.title')
      },
      xAxis: {
        categories: $('#user-subjects-charts').data('user-name'),
        crosshair: true
      },
      yAxis: {
        min: 0,
        title: {
          text: I18n.t('user_subjects.chart.y_axis')
        }
      },
      tooltip: {
        headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
        pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
            '<td style="padding:0"><b>{point.y}</b></td></tr>',
        footerFormat: '</table>',
        shared: true,
        useHTML: true
      },
      plotOptions: {
        column: {
          pointPadding: 0.2,
          borderWidth: 0
        }
      },
      series: [{
        name: I18n.t('user_subjects.chart.task_total'),
        data: $('#user-subjects-charts').data('total-number-tasks')
      }]
  });
});
