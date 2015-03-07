require 'bcrypt'
require_relative('base_api')

class LabAPI < BaseApi


  def initialize(request, session, cookies)
    super(request, session, cookies)
  end

  def process_request
    # process request and send request params
    # to correct call
    if request['api_method'] == 'create'
      return createNewLab
    end

  end


  def createNewLab

    response = {}

    begin

      # Verify inputs exist for request
      if(request['p1'].nil? || request['p2'].nil? || request['p3'].nil?)
        response['message'] = 'Parameters missing in request'
        response['success'] = false
        return response
      end

      user = getActiveUser(@cookies)

      new_lab = Lab.new(user_id: user.user_id, lab_title: request['p1'], lab_description: request['p2'],
      lab_video_url: request['p3'], lab_id: SecureRandom.uuid)
      new_lab.save

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