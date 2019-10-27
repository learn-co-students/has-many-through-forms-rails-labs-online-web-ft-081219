class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments
  accepts_nested_attributes_for :categories, :comments

  def categories_attributes=(hash)
    if hash.any? do |key,value|
      value.any? do |k,v|
        v==""
      end
    end
      return
    else
      hash.values.each do |one|
        category = Category.find_or_create_by(name:one[:name])
        self.categories << category
      end
    end
  end
end
