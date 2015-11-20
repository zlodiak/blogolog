class TagsController < ApplicationController
  before_action :set_tag, only: [:show]

  def index
    @tags = Tag.all.paginate(page: params[:page], :per_page => 10)
  end

  def show
    @posts = @tag.posts.paginate(page: params[:page], :per_page => 10)
  end

  private
    def set_tag
      @tag = Tag.find(params[:id])
    end

    def tag_params
      params[:tag]
    end
end
