class ExampleController < ApplicationController
  def rescue_action(e)
    @backtrace = e.awesome_backtrace
    render :action => "show"
  end

  def index
    explode!
  end

  def explode!
    raise "Oops!"
  end
end
