# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def ellipsis(str, size=100)
    return str if str.size <= size
    str[0,str.size-size] = "..."
    str
  end
end
