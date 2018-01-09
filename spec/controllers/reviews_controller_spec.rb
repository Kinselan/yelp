require 'rails_helper'

describe ReviewsController do


  describe "POST create" do
    let(:business) { Fabricate(:business) }
    let(:user)     { Fabricate(:user)     }

    it "redirects to root_path with inauthenticated user" do
      post :create, params: { business_id: business.slug } # todo - ask about id vs. slug in tests
      expect(response).to redirect_to root_path
    end

    context "with logged in user" do
      before { session[:user_id] = user.id }

      describe "with valid input" do
        before do
          post :create, params: { review: Fabricate.attributes_for(:review), business_id: business.slug }
        end

        it "saves the review" do
          expect(Review.count).to eq(1)
        end
        it "associates the review with the current user" do
          expect(Review.first.user).to eq(user)
        end
        it "sets the flash notice" do
          expect(flash[:notice]).to be_present
        end
        it "redirects to the business_path" do
          expect(response).to redirect_to business_path(business)
        end
      end

      describe "with invalid input" do
        before do
          post :create, params: { review: Fabricate.attributes_for(:review, description: ""), business_id: business.slug }
        end
        it "does not save a review" do
          expect(Review.count).to eq(0)
        end
        it "sets flash error" do
          expect(flash[:error]).to be_present
        end
        it "renders business/show" do
          expect(response).to render_template 'businesses/show'
        end
      end
    end
  end
end
