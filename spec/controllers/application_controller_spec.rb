require "spec_helper"
require "ruby_debug"

describe ApplicationController do

  controller do
    def index
      render :nothing => true
    end
  end

  describe "Validation for Facebook" do
    before(:each) do
      @oauth = stub('oauth')
      @oauth.stub(:parse_signed_request).with("unauthorized").and_return({})
      @oauth.stub(:parse_signed_request).with("authorized").and_return("user_id" => "1234567890")
      @oauth.stub(:url_for_oauth_code).and_return("www.www.www")
      @graph = stub('graph')
      @graph.stub(:get_object).with("me").and_return(@me = stub('me'))
    end

    it "render 404.html page if not in Facebook" do
      get :index
      response.response_code.should == 404
    end

    it "render OAuth Dialog script if not authorized" do
      Koala::Facebook::OAuth.should_receive(:new).and_return(@oauth)
      
      get :index, :signed_request => "unauthorized"
      response.body.should =~ /<script>.*www\.www\.www.*<\/script>/
    end

    it "create graph if authorized" do
      Koala::Facebook::OAuth.should_receive(:new).and_return(@oauth)
      Koala::Facebook::GraphAPI.should_receive(:new).and_return(@graph)
      
      get :index, :signed_request => "authorized"
      assigns[:graph].should == @graph
      assigns[:me].should == @me
      session[:facebook_uid].should == "1234567890"
    end
  end
end
