require 'bcrypt'
require_relative('base_api')

class LabAPI < BaseApi


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



      response['lab_id'] = new_lab.lab_id
      response['message'] = 'New lab created'
      response['success'] = true
      return response

    rescue Exception => e
      response['message'] = e.message
      response['success'] = false
      return response
    end
  end


end