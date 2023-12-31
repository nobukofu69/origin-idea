# Origin Idea
## サービスコンセプト
アイデアを形にするマッチングサービス

## 対象ユーザー
例①
- 30代男性
- 会社員
- エンジニア転職のためポートフォリオを作る予定だが、何を作るかは明確に決まっていない
- 作りたい分野は決まっているが、どんなものを作れば良いかわからない
- エンジニア転職で評価されるポートフォリオのテーマが思い浮かばない
- 自分で考えてみたが、1週間ほど経っても自身のアイデアを言語化できずもどかしさを感じている

例②
- 20代女性
- OL 兼 インスタグラマー
- SNSで得た知名度を使い､収益につながる何かをしたいと考えている
- いくつかアイデアはあるものの､成功するか不安で尻込みしている｡
- できれば自身のアイデアについて､第三者に相談したいと考えている｡

## ユーザーの課題
- 漠然としたアイデアはあるものの､具体的な形までアイデアを落とし込めない
- 思いついたアイデアが､自身の課題を解決できるか不安

## どんなサービスで課題を解決するのか？
アイデアを形にしたい人(アイデア募集者)と､アイデア出しをサポートしてくれる人(コンサルタント)とのマッチングサービスで解決します｡

### アイデア募集者(依頼者)
- カテゴリーやキーワードを元にコンサルタントを検索します｡
- 自身のニーズにマッチするコンサルタントが見つかったら､以下の内容を記載して､コンサルタントにリクエストを依頼します｡
  - 現在の状況
  - なぜアイデア出しが必要なのか
  - アイデア出しにあたり困っていること
  - いつまでにアイデアを形にする必要があるか

### コンサルタント(提供者)
- プロフィールに自身の経歴やスキルを記載の上､コンサルタントとして登録します｡
- コンサルティングの依頼が上がったら､依頼内容を見た上で依頼を受けるか決めます｡
- 依頼を受理したらマッチング成立です｡マッチング成立後は依頼者とチャットでやりとりし､アイデア出しに関する支援を行います｡

## サービス開発の背景
自分自身がポートフォリオ作成の際､アイデアを形にすることができずもどかしさを感じたことがきっかけです｡自分と同じようにアイデアを形にすることに苦慮している人がいるのではないかと考え､本サービスを開発しました｡

## 開発で苦労したこと
ActionCableを使ったチャット機能の実装に苦労しました｡
### 1. チャットページでリロードしないと､WebSocket通信が確立できない
チャットページに遷移した時点で､WebSocket通信が確立していない状態でした｡この原因について調査した結果､Turboによりページ遷移時の読み込みが一部省略されていることが原因であることがわかりました｡JavaScriptでページ遷移時のイベントを契機にWebSocket通信を確立するコードを記述することで､WebSocket通信が確立できるようになりました｡

### 2. 投稿したメッセージが重複して表示される
項番1.の問題を回避後､この問題が発生しました｡調査した結果､この問題はチャットページを一度離れてから再度チャットページに遷移した時に発生することがわかりました｡この挙動から､チャットページを離れた時にWebSocket通信が切断されていないことが問題だと考え､チャットページを離れた時にWebSocket通信を切断するコードを記述したところ事象が解消しました｡

## 機能要件
- ユーザー登録
- ユーザーログイン
- ゲストユーザーログイン
- ユーザーアカウントの編集
- コンサルタントの検索
- コンサルタント登録
- コンサルティングのリクエスト
- チャット(ActionCable)
- メッセージ通知
- コンサルタントの評価(advanced)

## 6. 非機能要件
- 保守性: githubへのpush時､静的解析ツールで自動チェックを行う
- 運用性: mainブランチにマージしたら自動デプロイする
- スマホ: PC両方に対応