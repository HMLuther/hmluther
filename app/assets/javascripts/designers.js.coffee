$(document).on "turbolinks:load", ->

	groupAlpha = $('.group-alpha')
	groupCountry = $('.group-country')

	$('.country-content').hide()
	groupAlpha.addClass('active')

	groupAlpha.on "click", () ->
		groupAlpha.addClass('active')
		groupCountry.removeClass('active')
		$('.country-content').fadeOut()
		$('.alpha-content').fadeIn()

	groupCountry.on "click", () ->
		groupCountry.addClass('active')
		groupAlpha.removeClass('active')
		$('.alpha-content').fadeOut()
		$('.country-content').fadeIn()
