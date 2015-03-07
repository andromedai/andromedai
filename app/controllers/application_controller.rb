class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery

  def updateLoginAuthToken(user)

    # If token does not exist, create new one
    if user.auth_token.nil?
      user.auth_token = AuthToken.new
    else
      # Update token for new expiration date
      user.auth_token.auth_token_expires = 24.hours.from_now
    end

    # Save and return existing or newly created token
    user.auth_token.save
    return user.auth_token
  end

  def validateUserPermissions
    permission = validateAuthToken
    if !permission
      redirect_to login_path
    else
      return permission
    end
  end

  # Alternate version of validateAuthToken for when
  # the user must be determined from the session
  def validateAuthToken
    user = getActiveUser
    if !user.nil?
      if user.auth_token.nil? || user.auth_token.auth_token_expires < Time.now
        redirect_to login_path
        return false
      else
        return true # Token is still valid
      end
    end

    token_check = AuthToken.where('auth_token_id = ?', cookies[:auth_token]).first
    if !token_check.nil?
      return true
    end

    redirect_to login_path
    return false
  end

  # Validates that logged in user is a Student
  def validateStudent
    user = getActiveUser(cookies)
    if user.user_account_type == 'student'
      return true
    else
      redirect_to login_path
      return false
    end
  end

  # Validates that logged in user is a Teacher
  def validateTeacher
    user = getActiveUser(cookies)
    if user.user_account_type == 'teacher'
      return true
    else
      redirect_to login_path
      return false
    end
  end

  # Gets the active user based on the session user_id value
  # Returns nil if no user can be determined
  def getActiveUser(cookies=nil)
    authTokenID = session[:user_id]
    if !authTokenID.nil?
      authRecord = AuthToken.where('auth_token_id = ?', authTokenID).first
      if !authRecord.nil?
        user = User.where('user_id = ?', authRecord.user_id).first
        if !user.nil?
          # User was found successfully
          return user
        end
      end
    end

    # Check to see if cookie store can find user
    if !cookies.nil?
      token = AuthToken.where('auth_token_id = ?', cookies[:auth_token]).first
      if !token.nil?
        user = User.where('user_id = ?', token.user_id).first
        if !user.nil?
          # User was found successfully
          return user
        end
      end
    end

    # User was not found
    return nil
  end


  def checkLoggedIn
    user = getActiveUser
    if !user.nil?
      redirect_to user_dashboard_path
      return true
    else
      return false
    end
  end

end
