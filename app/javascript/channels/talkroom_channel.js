import consumer from "channels/consumer"

const appChat = consumer.subscriptions.create("TalkroomChannel", {
  connected() {
  },

  disconnected() {
  },

  received(data) {
    console.log('データ届いてるよ！')
    const messages = document.getElementById('messages');
    messages.insertAdjacentHTML('afterbegin', data['message']);
  },

  speak(data) {
    return this.perform('speak', data);
  }
});

window.document.onkeydown = function(event) {
  if(event.key == 'Enter') {
    appChat.speak({content: event.target.value});
    event.target.value = '';
    event.preventDefault();
  }
}