require 'rails_helper'

RSpec.describe LikesController, :type => :controller do
  before do
    user = create_user
    secret = user.secrets.create(content: "Oops")
    @like = user.likes.create(user: user, secret: secret)
  end

  describe "when not logged in" do
    before do
      session[:user_id] = nil
    end

    it "cannot access create" do 
      post :create
      expect(response).to redirect_to("/sessions")      
    end

    it "cannot access destroy" do
      delete :destroy, id: @like
    end
    
    describe "when signed in as the wrong user" do
      @wrong_user = create_user 'julius', 'julius@lakers.com'
      session[:user_id] = @wrong_user.id
    end 
  end
end