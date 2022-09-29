# Web3News

## 概要

Web3 に特化したニュースアプリです。
記事へのコメントを通じてコミュニケーションをとることが出来ます。
バックエンド API として GraphQL を採用しています。

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
