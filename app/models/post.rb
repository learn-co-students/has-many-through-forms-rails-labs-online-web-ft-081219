class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments

  def categories_attributes=(arg)
 
    arg.each do |attribute|
      new_category = Category.find_or_create_by(name: attribute["name"])
      self.categories << new_category
    end
  end

  def categories_attributes 
    self.categories if self.categories
  end

end
