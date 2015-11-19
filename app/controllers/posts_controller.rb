class PostsController < InheritedResources::Base
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]

  def index
    @posts = Post.where(id: params[:id]).paginate(page: params[:page], :per_page => 10)
  end

  def show
    @comment = Comment.new
    @comments = Comment.where(post_id: @post.id)#.paginate(page: params[:page], :per_page => 6)
    @likes_count = PostLike.where(post_id: @post.id).count

    # generate comment ability notice
    unless user_signed_in?
      @notice_comment_ability = 'Добавлять комментарии могут только авторизованные пользователи'
    end    
    
    # generate like status notice
    if user_signed_in?
      if PostLike.where(user_id: current_user.id, post_id: @post.id).count > 0
        @already_like_message = 'Вы уже проголосовали' 
      else
        @already_like_message = 'Вы ещё не проголосовали' 
      end
    end
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save      
      redirect_to @post, notice: 'posts was successfully created.'
    else
      render :new 
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'posts was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to post_url, notice: 'posts was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like_change
    like = PostLike.where(user_id: current_user.id, post_id: params[:post_id])

    if like.count > 0
      like.first.destroy
    else
      PostLike.create(user_id: current_user.id, post_id: params[:post_id])
    end

    redirect_to user_post_path(current_user, params[:post_id])

  end

  def all_posts
    @posts = Post.paginate(page: params[:page], :per_page => 10)
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body, :post_id)
    end
end

