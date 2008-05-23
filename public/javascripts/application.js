// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function show_page(page) {
  $$('#pages > li').invoke('hide')
  $(page).show()
  return false
}

function toggle_frame(index) {
  $('frame_'+index).toggle()
  return false
}