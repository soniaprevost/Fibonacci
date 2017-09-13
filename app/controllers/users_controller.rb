class UsersController < Clearance::UsersController
  def create
    @user = user_from_params

    if @user.save
      sign_in @user

      redirect_back_or url_after_create
    else
      render :new
    end
  end

  private

  def user_from_params
    user_params = params[:user] || Hash.new
    first_name = user_params.delete(:first_name)
    last_name = user_params.delete(:last_name)
    address = user_params.delete(:address)
    situation = user_params.delete(:situation)
    pdl = user_params.delete(:pdl)
    email = user_params.delete(:email)
    password = user_params.delete(:password)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.first_name = first_name
      user.last_name = last_name
      user.address = address
      user.situation = situation
      user.pdl = pdl
      user.email = email
      user.password = password
    end
  end

  def user_params
    params[:user].permit(:email, :password, :first_name, :last_name, :address, :situation, :pdl)
  end
end
