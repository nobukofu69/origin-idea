# 設計

<details>
<summary>業務フロー</summary> 
<img src="https://github.com/nobukofu69/origin-idea/blob/main/documents/workflow.png">
</details>

<details>
<summary>画面遷移図</summary> 
<img src="https://github.com/nobukofu69/origin-idea/blob/main/documents/screen_flow_diagram.png">
</details>

<details>
<summary>ワイヤーフレーム</summary>
https://www.figma.com/file/ew0keNTFevdtX6VqjzO40v/Origin-Idea?type=design&node-id=0-1&mode=design&t=L05naf7mpYNbSHjR-0
</details>

<details>
<summary>テーブル定義書</summary>

### users
| カラム名 | データ型 | NULL | キー | 初期値 | AUTO INCREMENT | 説明 |
|------|--------|------|----|------|----------------|------|
| id | INTEGER | No | PK | | Yes | ユーザーID |
| username | VARCHAR(255) | No | | | | ユーザーネーム |
| profile | TEXT | Yes | | | | プロフィール |
| profile_image_id | STRING | Yes | | | | プロフィール画像 |
| email | VARCHAR(255) | No | | | | メールアドレス |
| password | STRING | No | | | | パスワード |
| profession | VARCHAR(255) | Yes | | | | 職業 |
| age | INTEGER | Yes | | | | 年齢 |
| rating | INTEGER | Yes | | | | 評価 |
| is_consultant | BOOLEAN | No | | False | | コンサルタント登録フラグ |

### requests
| カラム名 | データ型 | NULL | キー | 初期値 | AUTO INCREMENT | 説明 |
|------|--------|------|----|------|----------------|------|
| id | INTEGER | No | PK | | Yes | 依頼ID |
| requester_id | INTEGER | No | FK | | | 依頼者ID |
| consultant_id | INTEGER | Yes | FK | | | コンサルタントID |
| request_content | TEXT | No | | | | 依頼内容 |
| request_date | DATETIME | No | | | | 依頼日時 |
| status | VARCHAR(10) | No | | | | 依頼内容のステータス |
| is_read | BOOLEAN | No | | False | | 既読フラグ |
| talk_room_status | VARCHAR(10) | No | | | | トークルームのステータス |
- 外部キー制約
  - `requester_id` は `users.id` に紐づく
  - `consultant_id` は `users.id` に紐づく

### messages
| カラム名 | データ型 | NULL | キー | 初期値 | AUTO INCREMENT | 説明 |
|------|--------|------|----|------|----------------|------|
| id | INTEGER | No | PK | | Yes | メッセージID |
| request_id | INTEGER | No | FK | | | 依頼ID |
| sender_id | INTEGER | No | FK | | | 送信者ID |
| receiver_id | INTEGER | No | FK | | | 受信者ID |
| message_content | TEXT | No | | | | メッセージ内容 |
| message_date | DATETIME | No | | | | メッセージ送信日時 |
| is_read | BOOLEAN | No | | False | | 既読フラグ |
- 外部キー制約
  - `request_id` は `requests.id` に紐づく
  - `sender_id` は `users.id` に紐づく
  - `receiver_id` は `users.id` に紐づく

</details>

<details>
<summary>ER図</summary>
<img src="https://github.com/nobukofu69/origin-idea/blob/main/documents/er.png">
</details>


<details>
<summary>システム構成図</summary>
<img src="https://github.com/nobukofu69/origin-idea/blob/main/documents/%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0%E6%A7%8B%E6%88%90%E5%9B%B3.drawio.png">
</details>