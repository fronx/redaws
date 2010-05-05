class BucketsController < ApplicationController
  before_filter :connect_to_aws

  def index
    @buckets = Bucket.all
  end

  def new
  end

  def create
    Bucket.create!(params[:bucket])
    redirect_to :action => index
  rescue => e
    flash[:error] = e.message
    @bucket = Bucket.new(params[:bucket])
    render :new
  end

protected

  def connect_to_aws
    AWSModel.connect
  end
end
