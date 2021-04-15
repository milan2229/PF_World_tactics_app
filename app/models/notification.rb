class Notification < ApplicationRecord

  default_scope->{order(created_at: :desc)}
  #default_scopeでデフォルトで並び順を作成日降順にしてるので常に新しい通知からデータから取ってこれる

  belongs_to :post, optional: true
  belongs_to :post_comment, optional: true
  belongs_to :visiter, class_name: 'User', foreign_key: 'visiter_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
  #optional:trueでnillを許可
end
