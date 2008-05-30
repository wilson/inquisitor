class ExampleController < ApplicationController
  BANNERS = [
    ["l33t hax0rs", "use browsable backtraces"],
    ["nothing comes between me", "and my browsable backtraces"],
    ["Over 98% of IT professionals", "prefer browsable backtraces"]
  ]

  def rescue_action(e)
    @exception = e
    @banner = BANNERS[rand(BANNERS.size)]
    render :action => "show"
  end

  def index
    try_something params[:one], params[:two]
  end

  def try_something(one, two)
    one + two
  end
end
