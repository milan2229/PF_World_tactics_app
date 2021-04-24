require "refile/s3"

# if !Rails.env.development?
aws = {
  access_key_id: ENV['AWS_ACCESS_KEY_ID'],
  secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
  region: "ap-northeast-1",
  bucket: "pf-prod-infra",
}
Refile.cache = Refile::S3.new(prefix: "cache", **aws)
Refile.store = Refile::S3.new(prefix: "store", **aws)
# end
# require 'refile/s3'

# # if !Rails.env.development? # 開発環境でS3へアップロードできているか確認する方法

# if Rails.env.production? # 本番環境の場合
#   aws = {
#     access_key_id: ENV['AWS_ACCESS_KEY_ID'], # アクセスキーID
#     secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'], # シークレットアクセスキー
#     region: 'ap-northeast-1', # リージョン
#     bucket: 'pf-prod-infra',
#   }
#   Refile.cache = Refile::S3.new(prefix: 'cache', **aws)
#   Refile.store = Refile::S3.new(prefix: 'store', **aws)
# end

