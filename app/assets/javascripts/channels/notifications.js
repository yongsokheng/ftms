if ($('meta[name=current-user]').attr('id').length > 0) {
  App.notifications = App.cable.subscriptions.create('NotificationsChannel', {
    connected: function() {
    },

    disconnected: function() {
    },

    received: function(data) {
      var notification = $('.number-notification');
      var number_notification = 0;

      if(notification.text() !== '') {
        number_notification = parseInt(notification.text());
      }

      number_notification = number_notification + 1;
      notification.html(number_notification);
      $('#slimScrollDiv .menu').prepend(data.content);
      show_notify(data.notify_content);
    }
  });
}
