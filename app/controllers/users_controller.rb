class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.where(user_status_id: 1).paginate(page: params[:page], :per_page => 10).order(created_at: :DESC)  
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)           
      flash[:success] = 'Данные профиля изменены'
      redirect_to user_path(@user)
    else
      flash.now[:error] = 'При обновлении данных профиля произошла ошибка'
      render  'edit'
    end     
  end

  def destroy
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:title, :email)
    end   
end
