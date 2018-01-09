require 'rails_helper'

describe SessionsController do
  describe "GET new" do
    it "sets @user" do #myflix didn't do this, but we need it set up for our form!
      get :new
      expect(assigns(:user)).to_not be_nil
    end
    it "renders new template (login page) for unauthenticated users" do
      get :new
      expect(response).to render_template :new
    end
    it "redirects to the home page for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to root_path
    end
  end

  describe "POST create" do
    let(:user) { Fabricate(:user) }
    describe "with valid credentials" do
      before { post :create, params: { email: user.email, password: user.password } }

      it "sets session-id to user.id" do
        expect(session[:user_id]).to eq(user.id)
      end
      it "sets flash notice" do
        expect(flash[:notice]).to_not be_nil
      end
      it "redirects to root path" do
        expect(response).to redirect_to root_path
      end
    end

    describe "with invalid credentials" do
      before { post :create, params: { email: user.email, password: user.password + "haxx0r"} }

      it "does not put the user into the session" do
        expect(session[:user_id]).to be_nil
      end

      it "sets flash error" do
        expect(flash[:error]).to_not be_nil
      end
      it "redirects to login_path" do
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "DELETE destroy" do
    before do
      session[:user_id] = Fabricate(:user).id
      delete :destroy
    end
    it "sets session-id to nil" do
      expect(session[:user_id]).to be_nil
    end
    it "sets flash notice" do
      expect(flash[:notice]).to_not be_nil
    end
    it "redirects to root path" do
      expect(response).to redirect_to root_path
    end
  end
end
