# API Controller that takes in API request, parses it, and
# sends it off to the correct model/process
# Created By: Christopher M. Wood
# Date: 02/05/2015
class ApiController < ApplicationController

  def api_documentation

  end

  # Pulls in the params and apis request info to be parsed
  def request_manager

    begin

    request.format = 'json'

    @@request = {}
    @@request['version'] = params[:version]
    @@request['api_name'] = params[:api]
    @@request['api_method'] = params[:method]
    @@request['p1'] = params[:p1]
    @@request['p2'] = params[:p2]
    @@request['p3'] = params[:p3]
    @@request['p4'] = params[:p4]
    @@request['p5'] = params[:p5]

    # Find appropriate apis to call for the request
    if (@@request['api_name'] == 'user')

      require(api_folder + 'user_api')
      api = UserAPI.new(@@request, session, cookies)
      return_val = api.process_request

    elsif (@@request['api_name'] == 'lab')
      require(api_folder + 'lab_api')
      api = LabAPI.new(@@request, session, cookies)
      return_val = api.process_request

    elsif (@@request['api_name'] == 'public')
      require(api_folder + 'public_api')
      api = PublicAPI.new(@@request, session, cookies)
      return_val = api.process_request

    else
      # Request matched no known apis and has failed
      return_val = {}
      return_val['message'] = 'Request does not match API Interface'
      return_val['success'] = false
    end

    # render json: return_val
    render json: JSON.pretty_generate(return_val)
    return true

    rescue Exception => e
      return_val = {}
      return_val['message'] = e.message
      return_val['success'] = false

      render json: JSON.pretty_generate(return_val)
      return true
      end
  end

  #
  # This function will grab the folder where we are storing the API libraries
  #
  def api_folder
    return File.dirname(__FILE__).sub('app/controllers','') + 'app/models/apis/'

  end

end