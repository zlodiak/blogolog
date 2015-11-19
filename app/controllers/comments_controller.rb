class CommentsController < InheritedResources::Base
  def new
    @comment = Comment.new(:parent_id => params[:parent_id])
    @parent_id = params[:parent_id]
    @post = Post.find(params[:post_id])
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.post_id = comment_params[:post_id]

    if @comment.save
      redirect_to user_post_path(current_user.id, comment_params[:post_id]), notice: 'comment was successfully created.'
    else
      render :new
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body, :parent_id, :post_id)
    end
end

