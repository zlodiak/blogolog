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

    respond_to do |format|
      if @comment.save
        format.html { redirect_to user_post_path(current_user.id, comment_params[:post_id]), notice: 'comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body, :parent_id, :post_id)
    end
end

