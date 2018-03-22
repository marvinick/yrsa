var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

$(function() {
  var Notifications;
  return Notifications = (function() {
    function Notifications() {
      this.handleSuccess = bind(this.handleSuccess, this);
      this.getNewNotifications();
      this.notifications = $("[data-behavior='notifications']");
      if (this.notifications.length > 0) {
        this.handleSuccess(this.notifications.data('notifications'));
      }
    }

    Notifications.prototype.getNewNotifications = function() {
      return $.ajax({
        url: '/notifications.json',
        dataType: 'JSON',
        method: 'GET',
        success: this.handleSuccess
      });
    };

    Notifications.prototype.handleSuccess = function(data) {
      var items;
      items = $.map(data, function(notification) {
        return notifications.template;
      });
      $("[data-behavior='unread-count']").text(items.length);
      return $("[data-behavior='notification-items']").append(items);
    };

    return Notifications;

  })();
});
