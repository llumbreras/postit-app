class Comment < ActiveRecord::Base
  belongs_to :author, foreign_key:'user_id', class_name:'User'
  belongs_to :post

  validates :body, presence:true
end
