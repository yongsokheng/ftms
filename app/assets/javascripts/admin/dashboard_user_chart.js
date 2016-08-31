$(document).on('turbolinks:load', function() {
  var data_chart = $('#user-sign-up-chart').data('chart');
  $('#user-sign-up-chart').highcharts({
    chart: {
      type: 'column'
    },
    title: {
      text: I18n.t('charts.user_sign_up.title')
    },
    xAxis: {
      type: 'category'
    },
    yAxis: {
      allowDecimals: false,
      min: 0,
      title: {
        text: I18n.t('charts.user_sign_up.number_user')
      }
    },
    legend: {
      enabled: false
    },
    credits: {
      enabled: false
    },
    tooltip: {
      pointFormat: I18n.t('charts.user_sign_up.number_user_show')
    },
    series: [{
      data: data_chart,
      dataLabels: {
        enabled: true,
        color: '#FFFFFF',
        align: 'center',
        format: '{point.y:.1f}',
        y: 5,
        style: {
          fontSize: '16px',
          fontFamily: 'Verdana, sans-serif'
        }
      }
    }]
  });
});
