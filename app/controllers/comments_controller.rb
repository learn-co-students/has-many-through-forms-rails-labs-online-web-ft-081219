class CommentsController < ApplicationController

  def create

    
    p find_by_user_id[:user_id]
    p find_by_user_username[:user_attributes_username]
    comment = Comment.create(comment_params)
    post = Post.find_by(params[:id]) 
    post.comments << comment
    user = User.find_by(username: find_by_user_id[:user_id] )
    if user 
      # user.comments << comment
    else 
      user = User.find_or_create_by(username: find_by_user_username[:user_attributes_username])
      # user.comments << comment
    end
     user.comments << comment
    
    redirect_to comment.post
   
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id, user_attributes:[:username])
  end

  def find_by_user_id 
    params.require(:comment).permit(:user_id)
  end

  def find_by_user_username
    params.require(:comment).permit(:user_attributes_username)
  end
end
