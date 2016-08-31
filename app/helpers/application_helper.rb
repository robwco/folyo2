module ApplicationHelper
  def form_error_for(object, field)
    "
      <p style=\"color:#d9666a; margin-left: .25em; font-weight: 400; font-size: 13px; margin: -.25em 0 0;\">#{object.errors[field].join(", ")}</p>
    ".html_safe if object && object.errors.include?(field)
  end

  def formatted_price(amount)
    sprintf("$%0.2f", amount / 100.0)
  end
  
  def markdown(text)
    if text
      markdown = Redcarpet::Markdown.new(
        Redcarpet::Render::HTML.new
      )
      markdown.render(text).html_safe
    end
  end

  def render_google_analytics
    #If you setup google analytics, uncomment the following line and delete the line after that. 
    #Then update the UA-XXXXX code at the bottom.
    #return '' unless Rails.env.production?
	  return '' unless true || Rails.env.production?

    "
    <!-- Google Analytics -->
    <script>
      (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
      (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
      m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
      })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

      ga('create', 'UA-45184123-4', 'auto');
      ga('send', 'pageview');
    </script>
    ".html_safe
  end
end
