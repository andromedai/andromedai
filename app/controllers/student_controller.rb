class StudentController < ApplicationController

  before_filter :validateAuthToken

  def student_dashboard

  end

end