$(document).on "turbolinks:load", ->
	
  # $('.collection-subnav #active-toggle.active .inactive-button').hide()
  # $('.collection-subnav #active-toggle.active .active-button').show()

  # $('.collection-subnav #active-toggle.inactive .active-button').hide()
  # $('.collection-subnav #active-toggle.inactive .inactive-button').show()

	$('#collection-items-section .inactive .inactive-button').hide()
	$('#collection-items-section .inactive .active-button').show()

	$('#collection-items-section .active .active-button').hide()
	$('#collection-items-section .active .inactive-button').show()