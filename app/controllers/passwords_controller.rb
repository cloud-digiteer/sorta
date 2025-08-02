class PasswordsController < Devise::PasswordsController

  def new 
  end
  
  def create
    user = User.find_by(email: params[:email])
    if user.present?
      new_password = Devise.friendly_token.first(8)
      user.password = new_password
      user.password_confirmation = new_password

      if user.save
        flash[:notice] = "Your new password is: #{new_password}"
        redirect_to new_user_session_path
      else
        flash[:alert] = "Failed to reset password"
        render :new
      end
    else
      flash[:alert] = "Email not found"
      render :new
    end
  end
end
