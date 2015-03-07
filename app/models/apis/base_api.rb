# Represents a BaseAPI to be extended by other more
# specific api's. This is used to hold specific references
# used by all api's on the site.
# Author: Christopher M. Wood
# Contact: cmw2379@vt.edu
# Created_On: 2/28/2015
class BaseApi < ApplicationController

  attr_accessor :request, :session, :params

  # All class variables to be shared
  @request
  @session
  @response
  @cookies

  # Used to initialize the API with the calling request
  # the session and the parameters sent
  def initialize(request, session, cookies)
    @request = request
    @session = session
    @response = {}
    @cookies = cookies
  end

  def getUser(user_id)
    return User.where('user_id=?', user_id)
  end

end