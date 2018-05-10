class Secret < ActiveRecord::Base
  belongs_to :user
  has_many :users, through: :likes
  has_many :likes 
  validates :content, presence: true
end
