import { createConsumer } from "@rails/actioncable"

// グローバルにAppを定義
window.App = {};

// consumerを作成し、App.cableに代入
App.cable = createConsumer();

// 外部でappChatを定義
let appChat;

addEventListener('turbo:load', () => {
  // トークルームの要素を取得
  const talkRoom = document.getElementById('talk-room');

  // トークルームが存在し、かつトークルームのステータスがclosedでない場合のみ以下の処理を実行
  if (talkRoom && talkRoom.dataset.talkroomStatus == 'opened') {

    // URLからconsultation_idを取得
    const url = window.location.href;
    const consultationId = url.split('/')[4];

    // サブスクリプションを作成
    appChat = App.cable.subscriptions.create({
      channel: 'TalkroomChannel', consultation_id: consultationId
    }, {
      connected() {
      },

      disconnected() {
      },

      received(data) {
        const messages = document.getElementById('messages');
        messages.insertAdjacentHTML('beforeend', data['message']);
        messages.scrollTop = messages.scrollHeight;
      },

      speak(data) {
        return this.perform('speak', data);
      }
    });

    document.getElementById('chat-form').addEventListener('submit', (e) => {
      e.preventDefault(); // フォームのデフォルトの送信動作を無効化
      const contentInput = document.getElementById('content');
      if (contentInput.value.trim() === '') {
        alert('文字を入力してください');
        return;
      }
      appChat.speak({consultation_id: consultationId, content: contentInput.value});
      contentInput.value = '';
    });
  }
});

// ページがアンロードされる前にサブスクリプションを解除
addEventListener('turbo:before-cache', () => {
  if (appChat) {
    appChat.unsubscribe();
  }
});

// ページの戻る・進むボタンを押したときにサブスクリプションを解除
window.addEventListener('popstate', () => {
  if (appChat) {
    appChat.unsubscribe();
  }
});


// メッセージのスクロールを一番下にする
document.addEventListener('DOMContentLoaded', function() {
  var messagesDiv = document.getElementById('messages');
  messagesDiv.scrollTop = messagesDiv.scrollHeight;
});