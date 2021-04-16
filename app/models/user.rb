class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, uniqueness: true

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post
  attachment :profile_image

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_many :follower_user, through: :followed, source: :follower
  has_many :following_user, through: :follower, source: :followed
  # foreign_keyは入口  sourceは出口

  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :room, through: :user_rooms

  has_many :active_notifications, class_name: "Notification",
                                  foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification",
                                   foreign_key: "visited_id", dependent: :destroy

  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # すでにフォロー済みであればtrue返す
  def following?(user)
    following_user.include?(user)
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def create_notification_follow!(current_user)
    # 同じ通知が存在しない時だけレコードを作成
    temp = Notification.where([
      "visiter_id = ? and visited_id = ? and action = ? ",
      current_user.id, id, 'follow',
    ])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
end
