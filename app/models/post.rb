class Post < ApplicationRecord
  has_one_attached :genre
  has_many :comments
  has_many :favorites
  belong_to :user
end
