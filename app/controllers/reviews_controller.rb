class ReviewsController < ApplicationController
  before_action :require_user

  def create
    # @comment = @post.comments.build(params.require(:comment).permit(:body))
    @business = Business.find_by(slug: params[:business_id])
    @review = @business.reviews.build(params.require(:review).permit(:description))
    @review.user = current_user

    if @review.save
      flash[:notice] = 'Your review has been saved.'
      redirect_to business_path(@business)
    else
      flash[:error] = 'Your review has was ignored. Nobody likes you.'
      render 'businesses/show'
    end
  end
end
