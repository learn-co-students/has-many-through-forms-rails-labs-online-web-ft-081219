class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  accepts_nested_attributes_for :user, reject_if: proc {|attributes|attributes.any?{|a|a.blank?}}

  def user_attributes=(hash)
    if hash[:username].empty?
    else
      self.user = User.find_or_create_by(username:hash[:username])
      self.user.update(hash)
    end
  end

  def username_blank?
    user_attributes['username'].blank?
  end

end
