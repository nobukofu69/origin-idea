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
| email | VARCHAR(255) | No | UK | | | メールアドレス |
| password | VARCHAR(255) | No | | | | パスワード |
| birthdate | DATE | Yes | | | | 生年月日 |
| gender | VARCHAR(255) | No | | | | 性別 |
| profession | VARCHAR(255) | Yes | | | | 職業 |
| profile | TEXT | Yes | | | | プロフィール |
| profile_image_id | VARCHAR(255) | Yes | | | | プロフィール画像 |
| skill | TEXT | Yes | | | | スキル/知識/資格 |
| rating | INTEGER | Yes | | | | 評価 |
| is_consultant | BOOLEAN | No | | False | | コンサルタント登録フラグ |

### consultations
| カラム名 | データ型 | NULL | キー | 初期値 | AUTO INCREMENT | 説明 |
|------|--------|------|----|------|----------------|------|
| id | INTEGER | No | PK | | Yes | コンサルテーションID |
| consultant_id | INTEGER | No | FK | | | コンサルタントID |
| requester_id | INTEGER | No | FK | | | 依頼者ID |
| request_content | TEXT | No | | | | 依頼内容 |
| answer_deadline | DATETIME | No | | | | 回答期限 |
| status | INTEGER | No | | 0 | | 依頼内容のステータス |
| is_read | BOOLEAN | No | | False | | 既読フラグ |
- 外部キー制約
  - `consultant_id` は `users.id` に紐づく
  - `requester_id` は `users.id` に紐づく

### messages
| カラム名 | データ型 | NULL | キー | 初期値 | AUTO INCREMENT | 説明 |
|------|--------|------|----|------|----------------|------|
| id | INTEGER | No | PK | | Yes | メッセージID |
| sender_id | INTEGER | No | FK | | | 送信者ID |
| consultation_id | INTEGER | No | FK | | | コンサルテーションID |
| content | TEXT | No | | | | メッセージ内容 |
| is_read | BOOLEAN | No | | False | | 既読フラグ |
- 外部キー制約
  - `sender_id` は `users.id` に紐づく
  - `consultation_id` は `consultations.id` に紐づく

</details>

<details>
<summary>ER図</summary>
<img src="https://github.com/nobukofu69/origin-idea/blob/main/documents/er.png">
</details>


<details>
<summary>システム構成図</summary>
<img src="https://github.com/nobukofu69/origin-idea/blob/main/documents/%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0%E6%A7%8B%E6%88%90%E5%9B%B3.drawio.png">
</details>