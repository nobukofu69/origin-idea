import { createConsumer } from "@rails/actioncable"

// グローバルにAppを定義
window.App = {};

// consumerを作成し、App.cableに代入
App.cable = createConsumer();

addEventListener('turbo:load', () => {
  App.notifications = App.cable.subscriptions.create("NotificationsChannel", {
    connected() {
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      alert(data['message']);
    }
  });
});

addEventListener('turbo:before-cache', () => {
  if (App.notifications) {
    App.notifications.unsubscribe();
  }
});

addEventListener('turbo:before-fetch-request', () => {
  if (App.notifications) {
    App.notifications.unsubscribe();
  }
});

