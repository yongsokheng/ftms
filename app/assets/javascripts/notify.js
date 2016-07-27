function show_notify(notify_content) {
  if(!("Notification" in window) ) {
    alert(I18n.t("layouts.notifications.warning"));
    return;
  }

  if(Notification.permission !== "granted")
    Notification.requestPermission();

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
