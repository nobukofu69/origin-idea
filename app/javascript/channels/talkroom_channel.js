import consumer from "channels/consumer"

// URLからconsultation_idを取得
const url = window.location.href;
const consultationId = url.split('/')[4];

// サブスクリプションを作成
const appChat = consumer.subscriptions.create("TalkroomChannel", {
  connected() {
  },

  disconnected() {
  },

  received(data) {
    const messages = document.getElementById('messages');
    messages.insertAdjacentHTML('afterbegin', data['message']);
  },

  speak(data) {
    return this.perform('speak', data);
  }
});

window.document.onkeydown = function(event) {
  if (event.key == 'Enter') {
    if (event.target.value.trim() === '') {
      alert('文字を入力してください');
      return;
    }
    appChat.speak({consultation_id: consultationId, content: event.target.value});
    event.target.value = '';
    event.preventDefault();
  }
};
