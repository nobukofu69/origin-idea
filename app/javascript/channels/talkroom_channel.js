import consumer from "channels/consumer"

// 外部でappChatを定義
let appChat;

addEventListener('turbo:load', () => {
  // トークルームの要素を取得
  const talkRoom = document.getElementById('talk-room');

  // トークルームが存在し、かつトークルームのステータスがclosedでない場合のみ以下の処理を実行
  if (talkRoom && talkRoom.dataset.talkroomStatus == 'opened') {
    console.log('トークルームはオープンだね')

    // URLからconsultation_idを取得
    const url = window.location.href;
    const consultationId = url.split('/')[4];

    // サブスクリプションを作成
    appChat = consumer.subscriptions.create("TalkroomChannel", {
      connected() {
      },

      disconnected() {
      },

      received(data) {
        const messages = document.getElementById('messages');
        messages.insertAdjacentHTML('beforeend', data['message']);
      },

      speak(data) {
        return this.perform('speak', data);
      }
    });

    document.getElementById('content').addEventListener('keyup', (e) => {
      if (e.key === 'Enter') {
        if (e.target.value.trim() === '') {
          alert('文字を入力してください');
          return;
        }
        appChat.speak({consultation_id: consultationId, content: e.target.value});
        e.target.value = '';
        e.preventDefault();
      }
    });
  }
});

// ページがアンロードされる前にサブスクリプションを解除
addEventListener('turbo:before-cache', () => {
  if (appChat) {
    appChat.unsubscribe();
  }
});