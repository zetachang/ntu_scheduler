require 'spec_helper'

describe WelcomeController do

  describe "Validation for Facebook" do
    before(:each) do
      Koala::Facebook::OAuth.stub(:new).and_return(@oauth = double("oauth"))
      @oauth.stub(:parse_signed_request).with("unauthorized").and_return({})
      @oauth.stub(:parse_signed_request).with("authorized").and_return("oauth_token" => "qwerty")
      @oauth.stub(:url_for_oauth_code).and_return("oauth_dialog_url")
      Koala::Facebook::GraphAPI.stub(:new).and_return(@graph = double("graph"))
      @graph.stub(:get_object).with("me").and_return(@me = double("me"))
    end

    it "render 404.html page if not in Facebook" do
      get :index
      response.response_code.should == 404
    end

    it "render OAuth Dialog script if not authorized" do
      get :index, :signed_request => "unauthorized"
      response.body.should =~ /<script>.*oauth_dialog_url.*<\/script>/
    end

    it "save graph in session if authorized" do
      @controller.should_receive(:validate_session)

      get :index, :signed_request => "authorized"
      session[:graph].should == @graph
    end

  end

end
