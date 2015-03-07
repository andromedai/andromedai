# This is a single representation
# of an api response to be returned
class ApiResponse

  @@success
  @@response_time

  def initialize
    @@success = false
    @@response_time = { :time => Time.now.getutc.to_s.sub('T', '').sub('U C', 'UTC') }
  end

end