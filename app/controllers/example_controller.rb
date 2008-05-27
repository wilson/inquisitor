class ExampleController < ApplicationController
  BANNERS = [
    ["l33t hax0rs", "use browsable backtraces"],
    ["nothing comes between me", "and my browsable backtraces"],
    ["Over 98% of IT professionals", "prefer browsable backtraces"]
  ]

  def rescue_action(e)
    raise(e) unless e.respond_to?(:context) # TemplateError is evil
    @exception = e
    @banner = BANNERS[rand(BANNERS.size)]
    render :action => "show"
  end

  def index
    explode!
  end

  def explode!
    raise "Oops!"
  end
end
