# Web3News

## 概要

Web3 に特化したニュースアプリです。  
記事へのコメントを通じてコミュニケーションをとることが出来ます。  
バックエンド API として GraphQL を採用しています。

## スクリーンショット

<p>
<img src="https://user-images.githubusercontent.com/592846/192914165-96a9903f-0507-4b34-8ddc-62fbe01e2c9c.png" width="30%" />
<img src="https://user-images.githubusercontent.com/592846/192914172-f56e7e0b-078d-43fd-a198-a2fd787769f3.png" width="30%" />
<img src="https://user-images.githubusercontent.com/592846/192914178-3fdfddfe-d701-4052-87f6-3a89540a59c3.png" width="30%" />
</p>

## 使用技術

- Flutter 3.3.0
- Riverpod
- freezed
- graphql_flutter
- Firebase
  - Authentication
  - Storage
  - Remote Config
- Hasura（GraphQL API サーバー）

## 機能一覧

- ユーザ登録・ログイン（Firebase Authentication、Hasura）
- ユーザプロフィールの設定
- 記事をお気に入りへ追加
- 記事へのコメント
- 不快なユーザのブロック
- 記事への不適切なコメントを報告
