class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :tag_relationships, dependent: :destroy
  has_many :tags, through: :tag_relationships

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  validates :title, presence: true
  validates :body, presence: true

  def save_tags(savepost_tags)
      current_tags = self.tags.pluck(:name) unless  self.tags.nil?
      old_tags = current_tags - savepost_tags
      new_tags = savepost_tags - current_tags

      old_tags.each do |old_name|
        self.tags.delete Tag.find_by(name: old_name)
      end

      new_tags.each do |new_name|
        post_tag = Tag.find_or_create_by(name: new_name)
        self.tags << post_tag
   end
  end

end
