class ExampleController < ApplicationController
  def rescue_action(e)
    @exception = e
    render :action => "show"
  end

  def index
    explode!
  end

  def explode!
    raise "Oops!"
  end
end
