class CommentsController < InheritedResources::Base
  before_action :authenticate_user!, only: [:create, :new]

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

  def comment_like_change
    like = CommentLike.where(user_id: current_user.id, comment_id: params[:comment_id])

    if like.count > 0
      like.first.destroy
    else
      CommentLike.create(user_id: current_user.id, comment_id: params[:comment_id])
    end

    redirect_to :back
  end

  private
    def comment_params
      params.require(:comment).permit(:body, :parent_id, :post_id, :comment_id)
    end
end

