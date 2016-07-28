$(document).on("turbolinks:load", function() {
  check_notify_support();
});

function check_notify_support() {
  if(!("Notification" in window)) {
    return;
  }

  if(Notification.permission !== "granted")
    Notification.requestPermission();
}

function show_notify(notify_content) {
  check_notify_support();

  if(Notification.permission === "granted") {
    var option = {
      body: notify_content,
      dir: "auto",
    }

    var notification = new Notification(I18n.t("layouts.notifications.notification"), option);

    setTimeout(function() {
      notification.close();
    }, 10000);
  }
}
