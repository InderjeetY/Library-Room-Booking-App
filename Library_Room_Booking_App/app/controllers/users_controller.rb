class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize, only: [:new, :create, :sign_up_member]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  def show_admins
    @admins = User.where(user_type: 'admin')
    @sadmin = User.find_by(user_type: 'sadmin')
  end

  def show_members
    @members = User.where(user_type: 'member')
  end

  def sign_up_member
    session[:user_type_] = 'member'
    redirect_to '/users/new'
  end

  def sign_up_admin
    session[:user_type_] = 'admin'
    redirect_to '/users/new'
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def edit_personal_details
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.user_type = session[:user_type_]
    respond_to do |format|
      if @user.save
        if  @user.user_type == 'admin'
          format.html { redirect_to '/admin/index', notice: 'User was successfully created.' }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { redirect_to '/sessions/destroy', notice: 'User was successfully created.' }
          format.json { render :show, status: :created, location: @user }
        end
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if (User.find_by(email_id: user_params[:email_id]))[:id].to_s == (User.find_by(email_id: session[:email_id]))[:id].to_s
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to '/admin/index', notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to '/sessions/destroy', notice:'Cannot change other peoples details.'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      #if session[:user_type] == 'admin' || session[:user_type] == 'sadmin'
      format.html { redirect_to '/admin/index', notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email_id, :password, :password_confirmation, :user_type)
    end
end
