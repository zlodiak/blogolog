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
    @tags = @post.tags
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save    
      add_new_tags(@post)  
      flash[:success] = 'Пост успешно создан'
      redirect_to @post
    else
      flash.now[:error] = 'При создании поста произошла ошибка'
      render :new 
    end
  end

=begin
  def update
    begin  
      p 22222222222222222222222222222222222222222
      p post_params 
      p post_params[:title]
      @post.update(post_params)
      p @post
      add_new_tags(@post) if params[:tagnames]
      destroy_tags(params['delete_tags'], @post) if params['delete_tags']   
      flash[:success] = 'Пост успешно обновлён'
      redirect_to user_post_path(current_user.id, @post.id)
    rescue  
      p 33333333333333333333333333333333333333333333
      logger.debug 'update post is failed'
      flash.now[:error] = 'При обновлении поста произошла ошибка'
      render :edit
    end
  end
=end

  def update
    if @post.update(post_params)
      add_new_tags(@post) if params[:tagnames]  
      destroy_tags(params['delete_tags'], @post) if params['delete_tags']    
      flash[:success] = 'Пост успешно обновлён'
      redirect_to user_post_path(current_user.id, @post.id)
    else
      flash.now[:error] = 'При обновлении поста произошла ошибка'
      render :edit
    end
  end

  def destroy(real_delete = false)
    if @post.update(post_status_id: 2)
      flash[:success] = 'Пост успешно удалён'
      redirect_to all_posts_path
    end

    if real_delete == true
      @post.destroy
      flash[:success] = 'Пост успешно удалён из БД'
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

    def destroy_tags(tags,post)
      tags.each do |tag|   
        sql = "delete from 'posts_tags' where post_id = #{post.id} and tag_id = #{tag}"
        records_array = ActiveRecord::Base.connection.execute(sql)    
      end
    end 

=begin
    def add_new_tags(post)
      tagnames = params[:tagnames].split(/[, \.?!]+/) 
      tagnames.each do |tagname|
        tag = Tag.find_by(title: tagname.downcase)
        if tag
          sql = "select * from 'posts_tags' where post_id = #{post.id} and tag_id = #{tag.id}"

          begin
            records_array = ActiveRecord::Base.connection.execute(sql)     
            tag.posts << post if records_array.count == 0
          rescue
            logger.debug 'query for add association posts_tags is failed'
            raise 'add_new_tags error'
          end
        else
          begin
            tag = Tag.create(title: tagname.downcase)
            tag.posts << post
          rescue
            logger.debug 'query for create tag and add association posts_tags is failed'
            raise 'add_new_tags error'
          end
        end
      end
    end  

    def destroy_tags(tags,post)
      tags.each do |tag|
        sql = "delete from 'posts_tags' where post_id = #{post.id} and tag_id = #{tag}"

        unless ActiveRecord::Base.connection.execute(sql)  
          logger.debug 'query for delete tags is failed'
          raise 'destroy_tags error'          
        end
      end
    end  
=end

end

