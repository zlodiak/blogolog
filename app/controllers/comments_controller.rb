class CommentsController < InheritedResources::Base
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index
    @comments = Comment.all
    @comment = Comment.new
    # binding.pry
  end

  def show
  end

  def new
    @comment = Comment.new(:parent_id => params[:parent_id])
    @parent_id = params[:parent_id]
    @post = Post.find(params[:post_id])
  end

  def edit
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.post_id = comment_params[:post_id]
    p '------------------------------'
    p comment_params[:post_id]

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

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'comment was successfully destroyed.' }
      format.json { head :no_content }
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

