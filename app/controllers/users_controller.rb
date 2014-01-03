class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def show
    @user = User.find(params[:id])
    @user_activities = @user.activities
  end

  def view_profile
    @user = User.find(params[:id])
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :email, :bio, :photo, :location, :gender, :preferred_gender, :activity_ids => [])
    end
end
