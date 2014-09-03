$(document).on "page:change", ->
	
  $('.collection-subnav #active-toggle.active .inactive-button').hide()
  $('.collection-subnav #active-toggle.active .active-button').show()

  $('.collection-subnav #active-toggle.inactive .active-button').hide()
  $('.collection-subnav #active-toggle.inactive .inactive-button').show()

