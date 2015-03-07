class TeacherController < ApplicationController

  before_filter :validateAuthToken, :validateTeacher

  def teacher_dashboard

  end

end