class PostsController < InheritedResources::Base
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
  before_action :owner_post_or_admin_check, only: [:edit, :update, :destroy]

  def index
    @posts = Post.where(id: params[:id], post_status_id: 1).paginate(page: params[:page], :per_page => 10)
  end

  def show
    @comment = Comment.new
    @comments = Comment.where(post_id: @post.id)#.paginate(page: params[:page], :per_page => 6)
    @post_likes_count = PostLike.where(post_id: @post.id).count
    @tags = @post.tags

    # generate comment ability notice
    unless user_signed_in?
      @notice_comment_ability = 'Добавлять комментарии могут только авторизованные пользователи'
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
      add_new_tags(@post)  
      redirect_to @post, notice: 'posts was successfully created.'
    else
      render :new 
    end
  end

  def update
      if @post.update(post_params)
        redirect_to user_post_path(current_user.id, @post.id), notice: 'posts was successfully updated.'
      else
        render :edit
      end
  end

  def destroy(real_delete = false)
    if @post.update(post_status_id: 2)
      redirect_to all_posts_path, notice: 'posts was successfully destroyed.'
    end

    if real_delete == true
      @post.destroy
      redirect_to all_posts_path, notice: 'posts was successfully destroyed(erased from DB).'
    end
  end

  def posts_like_change
    like = PostLike.where(user_id: current_user.id, post_id: params[:post_id])

    if like.count > 0
      like.first.destroy
    else
      PostLike.create(user_id: current_user.id, post_id: params[:post_id])
    end

    redirect_to :back
  end

  def all_posts
    @posts = Post.where(post_status_id: 1).paginate(page: params[:page], :per_page => 10).order(created_at: :desc)
    @post = Post.new
  end

  private
    def set_post
      @post = Post.where(id: params[:id], post_status_id: 1).first
      error_404 unless @post
    end

    def post_params
      params.require(:post).permit(:title, :body, :post_id, :tagnames)
    end

    def owner_post_or_admin_check
      unless (current_user.id == @post.user_id) || (current_user.superadmin == true)
        error_403 unless current_user.id == @post.user_id   
      end
    end 

    def add_new_tags(post)
      tagnames = params[:tagnames].split(/[, \.?!]+/) 
      tagnames.each do |tagname|
        tag = Tag.find_by(title: tagname.downcase)
        if tag
          sql = "select * from 'posts_tags' where post_id = #{post.id} and tag_id = #{tag.id}"
          records_array = ActiveRecord::Base.connection.execute(sql)     
          tag.posts << post if records_array.count == 0
        else
          tag = Tag.create(title: tagname.downcase)
          tag.posts << post
        end
      end
    end    
end

