class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites


  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("nick_name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("nick_name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("nick_name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("nick_name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end

end
