require "spec_helper"
require "ruby_debug"

describe ApplicationController do

  controller do
    def index
      render :nothing => true
    end
  end

  describe "Validation for Facebook" do
    it "render 404.html page if not in Facebook" do
      get :index
      response.response_code.should == 404
    end

    it "render OAuth Dialog script if not authorized" do
      Koala::Facebook::OAuth.should_receive(:new).and_return(oauth = double("oauth"))
      oauth.should_receive(:parse_signed_request).with("somestring").and_return({})
      oauth.should_receive(:url_for_oauth_code).and_return("someurl")
      
      get :index, :signed_request => "somestring"
      response.body.should =~ /<script>.*someurl.*<\/script>/
    end

    it "create graph if authorized" do
      Koala::Facebook::OAuth.should_receive(:new).and_return(oauth = double("oauth"))
      oauth.should_receive(:parse_signed_request).with("somestring")
                                                 .and_return("user_id" => "123")
      
      get :index, :signed_request => "somestring"
      assigns[:graph].should_not be_nil
    end
  end
end
