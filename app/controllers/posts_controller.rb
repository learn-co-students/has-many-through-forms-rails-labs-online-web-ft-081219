class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @commenters = @post.comments.map{|comment| comment.user}.uniq
    @comment = Comment.new
    
  end

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    # p params
    
     string = params.require(:post).permit(categories_attributes: ["name"] )[:categories_attributes][0]["name"]
     array = params.require(:post).permit(category_ids: [] )[:category_ids]

     p "#{string} is empty #{string.empty?} "
     p array
     p !array.any?{|arg| arg != ""}
    

    if !string.empty?  && array.any?{|arg| arg != ""}
      post = Post.create(post_params)
    elsif string.empty? && !array.any?{|arg| arg != ""}
      post=Post.create(params.require(:post).permit(:title, :content))
    elsif string.empty? && array.any?{|arg| arg != ""}
        post=Post.create(params.require(:post).permit(:title, :content))

        array.each do |category_id|
          if !category_id.empty?
            category = Category.find(category_id) 
            post.categories << category 
            category.posts << post 
          end
        end

      elsif !string.empty? && !array.any?{|arg| arg != ""}
        post=Post.create(params.require(:post).permit(:title, :content))
        category = Category.find_or_create_by(name: string) 
            post.categories << category 
            category.posts << post 
    end

  
    redirect_to post
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, category_ids:[], categories_attributes: [:name])
  end
end
