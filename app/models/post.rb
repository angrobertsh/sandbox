class Post < ApplicationRecord
  validates :user_id, :body, presence: true

  belongs_to :user
  has_many :comments


end
