class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites

  validates :nick_name, presence: true
  validates :introduction, presence: true


  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nick_name = "ゲスト"
      user.introduction = "guest user introduction"
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end
  end


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
