require 'pry'

class BusinessesController < ApplicationController

  before_action :require_user, only: [:new, :create]

  def show
    # binding.pry
    # @business = Business.find(params[:id]) # can put this into a before action if you do it elsewhere
    @business = Business.find_by(slug: params[:id]) # can put this into a before action if you do it elsewhere
    @review = Review.new
  end

  def new
    @business = Business.new
  end

  def create
    @business = Business.new(business_params)

    if @business.save
      flash[:notice] = "You've added a nice business there!"
      redirect_to business_path(@business)
    else
      flash[:error] = "Your shit stinks. FIX IT."
      render :new
    end
  end

  private

  def business_params
    params.require(:business).permit!
  end
end
