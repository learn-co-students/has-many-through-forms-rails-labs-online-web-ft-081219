class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments

  def categories_attributes=(cat_attrs)
    cat_attrs.values.each do |cat_attr|
      if !cat_attr["name"].empty?
        category = Category.find_or_create_by(cat_attr)
        self.categories << category
      end
    end
  end
end
