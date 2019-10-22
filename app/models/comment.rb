class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  def user_attributes_username=(arg)
    p arg
  end

  def user_attributes_username 
  end
end
