# encoding: utf-8

class UsersController < ApplicationController
  def create
    @user = User.new(params[:user])
    @user.update_attributes(:name => @me["name"], :facebook_uid => @me["id"])

    respond_to do |format|
      format.json { render :json => @user.to_json }
    end
  end
end
