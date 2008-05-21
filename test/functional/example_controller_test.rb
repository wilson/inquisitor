require File.dirname(__FILE__) + '/../test_helper'

class ExampleControllerTest < ActionController::TestCase
  def test_index
    assert_raises(RuntimeError) do
      get :index
    end
  end
end
