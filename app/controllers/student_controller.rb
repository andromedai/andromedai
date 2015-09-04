class StudentController < ApplicationController

  before_filter :validateAuthToken, :validateStudent

  def student_dashboard

  end

end