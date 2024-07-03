AmazonQとCopilotの検証

- どんなプロンプトでどんなコードが生成されるか確認できる
- ブログを書くために検証した
 
https://iret.media/107732

## amazonq/main
 - moduleからネットワークが取得される
 - プロンプトは細かい
 - EC2はSSH接続までできる

## amazonq/main2
 - プロンプトはシンプル
 - コードはコメント内容で修正する必要あり
 - 代表リソースだけ作成

## copolot/main
amazonq/mainと同じ