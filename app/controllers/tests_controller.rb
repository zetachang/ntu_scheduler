class TestsController < ApplicationController
  def display
    respond_to do |format|
      format.html
      format.js
    end
  end
end
