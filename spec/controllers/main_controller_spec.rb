require 'spec_helper'

describe MainController do
  render_views
  
  before(:each) do
      	@base_title = "Entree"
    end

  describe "GET 'landing'" do
    
    it "should be successful" do
      get 'landing'
      response.should be_success
    end
  end
end
