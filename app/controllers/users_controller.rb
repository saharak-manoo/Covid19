class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:update, :destory]
  load_and_authorize_resource except: [:check_sign_in]
  skip_before_action :verify_authenticity_token
  protect_from_forgery with: :null_session
  
  def index
    data_table
  end

  def show
    render json: { user: @user&.decorate.as_json(
                                decorator_methods: [
                                  :full_name,
                                  :admin,
                                  :roles,
                                  :created_at_formatted,
                                  :updated_at_formatted,
                                  :deleted_at_formatted,
                                  :photo,
                                  :photo_url
                                ]) }
  end

  def update
    if @user.update(user_params)
      render json: { updated: true }, status: :ok
    else
      render json: { updated: false, errors: @user&.errors }, status: 500
    end  
  end

  def destroy
    @user.destroy

    render json: { user: @user }
  end

  def check_sign_in
    render json: { signed_in: user_signed_in?, 
                   current_user: current_user&.decorate.as_json(
                                              decorator_methods: [
                                                :full_name,
                                                :admin,
                                                :roles,
                                                :created_at_formatted,
                                                :updated_at_formatted,
                                                :deleted_at_formatted,
                                                :photo,
                                                :photo_url
                                              ]) }
                                            
  end  

  private

  def filter_users
    @users =  @users.where.not(id: current_user&.id) if user_signed_in?
    
    # search
    if params[:search].present?
      search = "%#{params[:search]}%"
      @users = @users.where("email ILIKE :search OR
                             concat(first_name,' ',last_name) ILIKE :search OR
                             phone_number ILIKE :search",
                             search: search)
    end

    # sort and order
    if params[:sort].present?
      @users = @users.order("#{params[:sort]} #{params[:order]}")
    end
  end

  def data_table
    filter_users

    total = @users.count
    limit = params[:limit].to_i
    offset = params[:page_now].present? ? (params[:page_now].to_i * limit) : params[:offset]
    @users = @users.order(updated_at: :desc).limit(limit).offset(offset)

    render json: { users: @users.decorate.as_json(
                                decorator_methods: [
                                  :full_name,
                                  :admin,
                                  :roles,
                                  :created_at_formatted,
                                  :updated_at_formatted,
                                  :deleted_at_formatted,
                                  :photo,
                                  :photo_url
                                ]),
                   page: { limit: limit,
                           total: total,
                           totalPages: (total / limit),
                           page_now: params[:page_now] }
                  }
  end 

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :phone_number, :photo)
  end
end