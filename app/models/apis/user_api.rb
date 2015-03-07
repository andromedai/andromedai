require 'bcrypt'
require_relative('base_api')

class UserAPI < BaseApi


  def initialize(request, session, cookies)
    super(request, session, cookies)
  end

  def process_request
    # process request and send request params
    # to correct call
    if request['api_method'] == 'get'
      return get_user_data
    elsif request['api_method'] == 'set'
      return set_user_data
    elsif request['api_method'] == 'signup'
      return signup
    elsif request['api_method'] == 'login'
      return login
    elsif request['api_method'] == 'logout'
      return logout
    end

  end


  # Gets user data provided user_id
  # request: api/v1/user/getdata/:user_id
  def get_user_data
    if(request['p1'].nil?)
      response['message'] = 'Parameter(s) missing in request'
      response['success'] = false
      return response
    end

    user = getUser(request['p1'])

    if(user.nil?)
      response['message'] = 'user does not exist'
      response['success'] = false
      return response
    end

    # Add user to response
    response['user'] = user

    response['message'] = 'data loaded'
    response['success'] = true
  end

  def set_user_data

  end

  def signup
    begin

      response = {}

      # Verify inputs exist for request
      if(request['p1'].nil? || request['p2'].nil? || request['p3'].nil? || request['p4'].nil?)
        response['message'] = 'Parameters missing in request'
        response['success'] = false
        return response
      end

      # Verify email is not in use
      if(!Email.where('email_address=?', request['p3']).first.nil?)
        response['message'] = 'Email already in use'
        response['success'] = false
        return response
      end

      # Create new user given inputs
      new_user = User.new(user_id: SecureRandom.uuid, user_firstname: request['p1'],
                          user_lastname: request['p2'], user_username: (request['p1'] + ' ' + request['p2']), user_verified: false)

      # Create new email for user created
      new_email = Email.create(user_id: new_user.user_id, email_id: SecureRandom.uuid, email_address: request['p3'])


      # Create new password hash for user created
      new_password = Password.new(user_id: new_user.user_id, password_id: SecureRandom.uuid,
      password: request['p4'], reset_key: 0)

      new_user.email = new_email
      new_email.save
      new_user.save
      new_password.save

      response['user'] = new_user
      response['email'] = new_email
      response['password'] = new_password
      response['message'] = 'new user created'
      response['success'] = true

      return response


    rescue Exception => e
      response['success'] = false
      response['message'] = e.message
      return response
    end
  end

 # Logs in user given email and password
  def login
    begin
      response = {}

      user_email = Email.where('email_address=?', request['p1']).first

      if user_email.nil?
        response['message'] = 'given email is not registered on this site'
        response['success'] = false
        return response
      end

      #Find user given email
      user = User.where('user_id=?', user_email.user_id).first

      if user.nil?
        response['message'] = 'no user exists for the given email'
        response['success'] = false
        return response
      end

      #Authenticate user
      if user.password.authenticate(request['p2'])

        #User authenticated
        token = updateLoginAuthToken(user)
        session[:user_id] = token.auth_token_id

        # Setup cookie for remember me option
        if request['p3']
          @cookies[:auth_token] = { :value => token.auth_token_id, :expires => 1.month.from_now }
        else
          @cookies[:auth_token] = nil
        end

        response['session_id'] = session[:user_id]
        response['message'] = 'User Authenticated'
        response['success'] = true
        return response
      else
        response['message'] = 'User could not be Authenticated'
        response['success'] = false
        return response
      end

    rescue Exception => e
      response['message'] = e.message
      response['success'] = false
      return response
    end
  end


  def logout
    response = {}
    begin
      user = getActiveUser(@cookies)

      if user.nil?
        response['message'] = 'No User was found'
        response['success'] = false
        return response
      end

      # Clear auth_token and session from holding value
      # and set token to expire at current Time.now
      user.auth_token.auth_token_id = ''
      user.auth_token.auth_token_expires = Time.now
      session[:user_id] = ''
      user.save

      # Clear the cookie
      @cookies.delete(:auth_token)

      response['session_format'] = user.auth_token.auth_token_id + '  ' + session[:user_id]
      response['message'] = 'User logged out'
      response['success'] = true
      return response

    rescue Exception => e
      response['message'] = e.message
      response['success'] = false
      return response
    end
  end


end