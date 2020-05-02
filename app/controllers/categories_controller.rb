class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @posts = @category.posts
  end

  def index
    @categories = Category.all
  end
end
