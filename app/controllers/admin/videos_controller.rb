class Admin::VideosController < ApplicationController
  before_action :require_admin

  def new
    @video = Video.new
  end
  
end
