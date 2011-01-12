module ApplicationHelper
  
  def logo
    image_tag("entree_logo.png", :alt => "Entree Lifestyle", :class => "round") 
  end
  
  # Return a title on a per-page basis.
   def title
     base_title = "Entree"
     if @title.nil?
       base_title
     else
       "#{base_title} | #{@title}"
     end
   end  
end
