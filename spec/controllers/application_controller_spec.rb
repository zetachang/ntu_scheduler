require "spec_helper"

describe ApplicationController do

  controller do
    def index
      render :text => "session exist"
    end
  end

  describe "Validation for session" do
    it "should show OAuth Dialog f user dosesn't have session" do
      Koala::Facebook::OAuth.stub(:new).and_return(@oauth = double("oauth"))
      @oauth.stub(:url_for_oauth_code).and_return("oauth_dialog_url")

      get :index
      response.body.should =~ /<script>.*oauth_dialog_url.*<\/script>/
    end
    
    it "should keep silent if user have session" do
      session[:graph] = (graph = double("graph"))
      graph.stub(:get_object).with("me").and_return(me = double("me"))

      get :index
      response.body.should == "session exist" 
      assigns[:graph].should_not be_nil
      assigns[:me].should_not be_nil
    end
  end 
  
end
