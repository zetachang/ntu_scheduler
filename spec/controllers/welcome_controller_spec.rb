require 'spec_helper'

describe WelcomeController do

  describe "Validation for Facebook" do
    before(:each) do
      Koala::Facebook::OAuth.stub(:new).and_return(@oauth = double("oauth"))
      @oauth.stub(:parse_signed_request).with("unauthorized").and_return({})
      @oauth.stub(:parse_signed_request).with("authorized").and_return("oauth_token" => "qwerty")
      Koala::Facebook::GraphAPI.stub(:new).and_return(@graph = double("graph"))
      @graph.stub(:get_object).with("me").and_return(@me = double("me"))
    end

    it "try to validate session if not first launch" do
      @controller.should_receive(:validate_session)

      get :index
    end

    it "render OAuth Dialog if not authorized" do
      @controller.should_receive(:oauth_dialog)
      get :index, :signed_request => "unauthorized"
    end

    it "save graph in session if authorized" do
      @controller.should_receive(:validate_session)

      get :index, :signed_request => "authorized"
      session[:graph].should == @graph
    end

  end

end
