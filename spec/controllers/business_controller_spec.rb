require 'rails_helper'

describe BusinessesController do
  describe 'GET show' do
    let(:business) { Fabricate(:business) }

    it "sets @business" do
      get :show, params: { id: business.slug }
      expect(assigns(:business)).to eq(business)
    end

    it "sets @review" do
      get :show, params: { id: business.slug }
      expect(assigns(:review)).to_not be_nil
    end
  end

  describe 'GET new' do
    it "redirects to root_path for un-authenticated users" do
      get :new
      expect(response).to redirect_to root_path
    end

    it "sets @business for logged in users" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(assigns(:business)).to_not be_nil
    end
  end

  describe 'POST create' do
    context "inauthenticated user" do
      it "sets flash error with inauthenticated user" do
        post :create
        expect(flash[:error]).to be_present
      end
      it "redirects to root_path with inauthenticated user" do
        post :create
        expect(response).to redirect_to root_path
      end
    end

    context "with authenticated user" do
      before do
        session[:user_id] = Fabricate(:user).id
      end
      context "with valid inputs" do
        it "saves the review" do
          post :create, params: { business: Fabricate.attributes_for(:business) }
          expect(Business.count).to eq(1)
        end
        it "redirects to the business_path" do # todo - ask if there is more efficient way
          business = Fabricate.attributes_for(:business)
          post :create, params: { business: business }
          new_business = Business.find_by(name: business[:name])
          expect(response).to redirect_to business_path(new_business)
        end

        context "with invalid inputs" do
          before do
            post :create, params: {business: Fabricate.attributes_for(:business, name: "")}
          end
          it "does not save" do
            expect(Business.count).to eq(0)
          end
          it "sets flash error" do
            expect(flash[:error]).to be_present
          end
          it "renders new" do
            expect(response).to render_template "businesses/new"
          end
        end
      end
    end
  end
end
