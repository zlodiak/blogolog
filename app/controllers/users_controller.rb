class UsersController < ApplicationController
  def index
    @users = User.where(user_status_id: 1).paginate(page: params[:page], :per_page => 10).order(created_at: :DESC)  
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
