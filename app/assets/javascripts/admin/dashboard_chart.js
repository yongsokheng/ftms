$(document).on('turbolinks:load', function() {
  var data_user_sign_up_chart = $('#user-sign-up-chart').data('chart');
  var data_new_course_chart = $('#new-course-chart').data('chart');
  var data_finish_course_chart = $('#finished-course-chart').data('chart');
  if (data_finish_course_chart.length == 0) {
    $('#finished-course-chart').hide();
  };
  if (data_new_course_chart.length == 0) {
    $('#new-course-chart').hide();
  };
  if (data_user_sign_up_chart.length == 0) {
    $('#user-sign-up-chart').hide();
  };

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
      data: data_user_sign_up_chart,
      color: '#cecece',
      dataLabels: {
        enabled: true,
        color: '#fff',
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

  $('#new-course-chart').highcharts({
    chart: {
      type: 'column'
    },
    title: {
      text: I18n.t('charts.new_course.title')
    },
    xAxis: {
      type: 'category'
    },
    yAxis: {
      allowDecimals: false,
      min: 0,
      title: {
        text: I18n.t('charts.new_course.number_course')
      }
    },
    legend: {
      enabled: false
    },
    credits: {
      enabled: false
    },
    tooltip: {
      pointFormat: I18n.t('charts.new_course.number_course_show')
    },
    series: [{
      data: data_new_course_chart,
      dataLabels: {
        enabled: true,
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

  $('#finished-course-chart').highcharts({
    chart: {
      type: 'column'
    },
    title: {
      text: I18n.t('charts.course_finished.title')
    },
    xAxis: {
      type: 'category'
    },
    yAxis: {
      allowDecimals: false,
      min: 0,
      title: {
        text: I18n.t('charts.course_finished.number_course')
      }
    },
    legend: {
      enabled: false
    },
    credits: {
      enabled: false
    },
    tooltip: {
      pointFormat: I18n.t('charts.course_finished.number_course_show')
    },
    series: [{
      data: data_finish_course_chart,
      color: 'green',
      dataLabels: {
        enabled: true,
        color: 'green',
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
