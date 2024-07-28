class Post < ApplicationRecord
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user

  validates :title, presence: true
  validates :genre, presence: true
  validates :discription, presence: true

 # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @post = Post.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @post = Post.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @post = Post.where("title LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end


  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
    #favorites.exists?(user_id: user.id)
  end
end
