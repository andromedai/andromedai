require 'bcrypt'
require_relative('base_api')

class PublicAPI < BaseApi


  def initialize(request, session, cookies)
    super(request, session, cookies)
  end

  def process_request
    # process request and send request params
    # to correct call
    if request['api_method'] == 'request-invite'
      return requestInvite
    end

  end


  def requestInvite

    response = {}

    begin

      # Verify inputs exist for request
      if(request['p1'].nil?)
        response['message'] = 'Parameters missing in request'
        response['success'] = false
        return response
      end

      if !validEmail(request['p1'])
        response['completion_message'] = 'Please enter a valid email address'
        response['message'] = 'Invalid email format'
        response['success'] = false
        return response
      end

      existing_request = InviteRequest.where('invite_request_email_address=?', request['p1']).first

      if !existing_request.nil?
        response['completion_message'] = 'You have already requested an invite.'
        response['message'] = 'Email already requested'
        response['success'] = false
        return response
      end

      new_request = InviteRequest.new(:invite_request_id => SecureRandom.uuid, :invite_request_email_address => request['p1'])
      new_request.save

      response['completion_message'] = 'Your request was received. Thank You!'
      response['message'] = 'Invite request added for ' + new_request.invite_request_email_address
      response['success'] = true
      return response

    rescue Exception => e
      response['message'] = e.message
      response['success'] = false
      return response
    end
  end


end