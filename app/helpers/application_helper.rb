module ApplicationHelper
  include TweetButton
  
  def bespin_setup(dom_id)
    render "layouts/bespin", :dom_id => dom_id
  end
end
