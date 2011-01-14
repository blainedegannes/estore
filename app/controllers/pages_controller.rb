class PagesController < ApplicationController
  
  def about
    @title = "About"
  end

  def contact
    @title = "Contact"
  end

  def sales
    @title = "Sales"
  end
end
