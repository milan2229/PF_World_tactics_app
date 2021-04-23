# World tactics
<img width="1427" alt="READMEスクリーンショット 2021-04-07 16 40 44"
src="https://user-images.githubusercontent.com/64453093/114139074-83554d00-9949-11eb-849a-51f8025e2f4a.png">

## サイト概要
サッカーの戦術を情報共有するサイト。
ユーザー同士で最新の戦術について語りあうSNS。

### サイトテーマ
日本サッカー界の戦術的理解度の低さなどを指摘されるなかで、ライトなサッカーファンや、現役でプレーしている育成年代から戦術をよりよく学びサッカーIQを向上させる
ことをテーマにしました。

### テーマを選んだ理由
自分自身サッカーを9年間をやっていた経験から戦術に対して個人的にあまり重要視していなかった部分があるため、
育成年代から海外サッカーの最新トレンドを学び戦術理解力を向上したいため。<br>
また、ライトなサッカーファンでも戦術を学びもっとサッカー観戦を楽しんでもらえるようにするため。

### ターゲットユーザ
* サッカー好きな人全般
* 現役でサッカーをやっている人。
* サッカー観戦をこれから趣味にしたい人

### 主な利用シーン
サッカー観戦時にリアルタイムで情報共有し、ピッチ上で何が起こっているのかを理解しより楽しむため。<br>
最新の戦術を自分達のチームに取り入れる。

### 使用技術
* Ruby 2.6.3
* Ruby on Rails 5.2.5
* MySQL 5.7.2.2
* Nginx
* Puma
* AWS
 * VPC
 * EC2
 * RDS
 * Route53
 * CloudWatch
 * S3
- RSpec

## AWS構成図
<img width="1427" alt="AWS構成図"
src="https://github.com/milan2229/PF_World_tactics_app/files/6362271/PF.AWS.pdf">
### GitHub Actions
* masterブランチへのpush時、RspecとRubocopが成功した場合のみEC2への自動デプロイが実行されます

## ER図
<img width="1427" alt="ER図"
src="https://github.com/milan2229/PF_World_tactics_app/files/6362295/erd.pdf">

### 機能一覧
* CRUD処理
* ユーザー登録、ログイン機能(devise)
* 投稿機能
* いいね機能(Ajax)
* コメント機能(Ajax)
* フォロー機能(Ajax)
* お問い合わせ
* 検索機能(ransack)
* DM機能
* タグ機能
* 画像スライダー
* ページネーション機能(kaminari)
* 通知機能
* バッチ処理(未読通知３件で翌朝９時にメールで通知)

機能一覧詳細
https://docs.google.com/spreadsheets/d/1ifacPpWqpcpGqtit_JDffgZ-z3Yy1WzUtKwoTtcJNZo/edit#gid=0
