require "spec_helper"

describe ApplicationController do

  controller do
    def index
      render :text => "session exist"
    end
  end

  describe "Validation for session" do
    it "should reload whole page if user dosesn't have session" do
      get :index
      response.body.should =~ /.*top\.location\.reload\(\)*/ 
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
