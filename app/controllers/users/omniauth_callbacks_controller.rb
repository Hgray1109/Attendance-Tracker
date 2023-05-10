class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    
 def github
    handle_auth "Github"
 end


 def google_oauth2
    handle_auth "Google"
 end
  
  def handle_auth(kind)
        # You need to implement the method below in your model (e.g. app/models/user.rb)
        @user = User.from_omniauth(request.env['omniauth.auth'])
        if @user.persisted?
  
          flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: kind
          sign_in_and_redirect @user, event: :authentication
        else
    
          session['devise.handle_auth_data'] = request.env['omniauth.auth'].except('extra') # Removing extra as it can overflow some session stores
          redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
        end
    end
    
  end