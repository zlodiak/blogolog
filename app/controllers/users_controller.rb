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

  def destroy(real_delete = false)
    if @user.update(user_status_id: 2)
      flash[:success] = 'Аккаунт пользователя удалён'
      redirect_to new_user_session_path
    end

    if real_delete == true
      @user.destroy
      flash[:success] = 'Аккаунт пользователя удалён из БД'
      redirect_to new_user_session_path
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:title, :email, :info)
    end   
end
