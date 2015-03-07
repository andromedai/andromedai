class PublicController < ApplicationController

  def labs

  end

  def lab_view
    @lab = Lab.where('lab_id=?', params[:lab_id]).first()
  end

end