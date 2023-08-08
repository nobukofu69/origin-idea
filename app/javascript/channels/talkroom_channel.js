import consumer from "channels/consumer"

const appChat = consumer.subscriptions.create("TalkroomChannel", {
  connected() {
  },

  disconnected() {
  },

  received(data) {
  },

  speak: function(message) {
    return this.perform('speak', {message: message});
  }
});

window.document.onkeydown = function(event) {
  if(event.key == 'Enter') {
    appRoom.speak(event.target.value);
    event.target.value = '';
    event.preventDefault();
  }
}