class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  def user_attributes=(user_attrs)
    user_attrs.values.each do |user_attr|
      if !user_attr.empty?
        user = User.find_or_create_by(username: user_attr)
        self.user = user
      end
    end
  end
end
