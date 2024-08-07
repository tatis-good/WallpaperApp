# UnsplashのAPIを利用した写真表示アプリ
<br>

## アプリ概要
このアプリは新着画像を5枚取得し、画面に表示するアプリとなっています。トップページでは、その日の新着画像を表示するためのAPIを使用しています。
<br><br>

## 工夫したポイント
・新着画像の取得と表示: 毎日表示する画像が変わるように、その日の新着画像データを取得するAPIを使用し、トップページに5枚の画像を表示しています。
画像を選択すると、詳細画面に遷移し、撮影者、配信地、更新日が表示されます。さらに、撮影者をタップすると、その撮影者の紹介サイトに遷移するようにしています。  
・色別画像の表示: トップページとは別に、ヘッダー部分のボタンで指定した色に対応する画像を表示するページを作成しました。この機能では別のAPIを使用し、公開されている仕様書を参考にして実装しました。  
・オリジナルフッターの構築: デザイナーがFigmaでデザインしたオリジナルの固定フッターを利用し、デザイン性を意識した構成を行いました。iOS標準のTabBarではなく、複数の部品を組み合わせてStoryboard上で作成しました。  
・アプリの紹介ページ: フッターにあるアプリ概要では、Unsplashの紹介を記述しており、ロゴ部分を押すとUnsplashの公式サイトに遷移するようにしています。
<br><br>

## 苦労したポイント
・オートレイアウトの設定: APIを利用してコレクションビューに画像を表示する際、オートレイアウトの設定に苦労しました。適切なサイズやレイアウトを実装するために、講師の助言や生成AIを活用して問題を解決しました。
<br><br>

## GIFアニメーション
![wallpaper](https://github.com/user-attachments/assets/ca79692f-13b9-4deb-bbcb-c5e7df9169e5)

