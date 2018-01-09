require 'rails_helper'

describe UsersController do
  #
  # describe "GET show" do
  #   it "sets @user"
  #   it "renders a page" # do we need this?
  # end
  #
  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    context "with valid input" do
      before { post :create, params: { user: Fabricate.attributes_for(:user) }}

      it "saves the user" do
        expect(User.count).to eq(1)
      end
      it "sets flash notice" do
        expect(flash[:notice]).to_not be_nil
      end
      it "redirects to root path" do
        expect(response).to redirect_to root_path
      end
    end

    context "with invalid input" do
      before { post :create, params: { user: Fabricate.attributes_for(:user, email: "") }}
      
      it "sets flash error" do
        expect(flash[:error]).to_not be_nil
      end
      it "renders new template" do
        expect(response).to render_template :new
      end
      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end

  end

end
