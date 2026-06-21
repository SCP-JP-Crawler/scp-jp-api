# SCP-JP Data API

SCP-JP Data APIへようこそ！

これは[SCP財団Wiki](http://scp-jp.wikidot.com/)の静的データダンプであり、記事タイプごとに分類されています。データは毎日クロールおよび更新されています。

このデータの利用方法は2通りあります。

1. 以下のリンクから直接ダウンロードする
2. [GitHubリポジトリ](https://github.com/SCP-JP-Crawler/scp-jp-api)から取得する

---

## 共通フィールド

### `history`

`history` フィールドには、時系列順に並んだオブジェクトのリストが含まれます。各オブジェクトには以下の情報があります。

* `author` : 編集者の表示名
* `author_href` : 編集者のWikidotページへのリンク（不明な場合は `false`）
* `comment` : 編集時のコメント
* `date` : 編集日時（例: `2020-02-20T19:10:00`）

### その他の共通フィールド

* `link` : URLのパス部分から生成された主キー
* `page_id` : Wikidot上のページID
* `created_at` : 作成日時
* `created_by` : 初回作成者のWikidotユーザー名（存在しない場合あり）
* `url` : 元ページへの直接リンク

---

# コンテンツとメタデータ

各SCP記事およびTaleには、

* メタデータ
* 記事本文

の両方が含まれています。

本プロジェクトでは、メタデータだけを利用したい場合に巨大な本文データを取得しなくて済むよう、両者を別ファイルに分離しています。

本文データも利用可能です。

各ページについて、

* `raw_content`

  * `#page-content` のHTML内容
* `raw_source`

  * 元となるWikitext

が保存されています。

これらにはストーリー本文が含まれますが、

* ナビゲーション
* 広告
* ヘッダー情報

などは除外されています。

BeautifulSoupによる軽微な整形以外の変更は行われていません。

記事に `content_file` フィールドがある場合は、そのファイルに本文が格納されています。ない場合は `raw_content` と `raw_source` に直接格納されています。

---

# SCPメインWikiデータ

## Hub

Hubはテーマ、カノン、題材などに基づいて記事をグループ化するページです。

Hubデータセットには、すべてのHubと、そのHubに所属する記事一覧が含まれています。

### データファイル

```text
data/scp/hubs/index.json
```

Hubデータは比較的小さいため、すべて1つのファイルに格納されています。

各Hubには以下のフィールドがあります。

* `title`

  * Hub名
* `references`

  * Hubに属する記事やTaleの `link` 一覧
* `tags`

  * Hubページのタグ
* `raw_content`

  * Hub本文

加えて共通フィールドも含まれます。

---

## Items（SCP記事）

SCP記事はWikiの中でも最も有名なコンテンツであり、このデータセットが最大規模です。

### メタデータファイル

```text
data/scp/items/index.json
```

全SCP記事のメタデータを格納しています。

追加フィールドは以下の通りです。

* `content_file`

  * 本文ファイルへの相対パス
* `references`

  * 関連記事一覧
* `tags`

  * タグ
* `title`

  * 記事タイトル
* `hubs`

  * 所属Hub一覧
* `images`

  * 記事内画像URL一覧
* `rating`

  * Wikidotの評価値
* `scp`

  * SCP番号表記（例: SCP-682）
* `scp_number`

  * 数値部分のみ（例: 682）
* `series`

  * 所属シリーズ

---

### コンテンツインデックス

```text
data/scp/items/content_index.json
```

キーがシリーズ名、値が本文ファイル名となる辞書です。

本文ファイルには、

* `raw_content`
* `raw_source`

が格納されており、`content_file` フィールドは存在しません。

---

## Tales

TalesはSCP世界観の短編小説です。

GOIに属さないすべてのTaleが収録されています。

### Taleインデックス

```text
data/scp/tales/index.json
```

主なフィールド：

* `content_file`
* `created_at`
* `created_by`
* `link`
* `page_id`
* `references`
* `tags`
* `title`
* `url`
* `hubs`
* `images`
* `rating`
* `history`

---

### Taleコンテンツインデックス

```text
data/scp/tales/content_index.json
```

キーが作成年、値が本文ファイルです。

本文ファイルには

* `raw_content`
* `raw_source`

が含まれます。

---

## GOI（Groups of Interest）

GOI（要注意団体）記事は、その団体の特色に合わせた独自フォーマットで作成されることが多い記事です。

### GOIメタデータ

```text
data/scp/goi/index.json
```

構造はTaleと同じです。

---

### GOI本文データ

```text
data/scp/goi/content_goi.json
```

GOIデータは比較的小さいため、すべて1ファイルに格納されています。

メタデータファイルと同じ構造ですが、

* `content_file`

の代わりに

* `raw_content`
* `raw_source`

が格納されています。

---

# ライセンス

このプロジェクトはSCP Wikiおよびその管理者とは無関係です。

Wikiのすべてのコンテンツは、SCP Wikiのライセンスに従います。
