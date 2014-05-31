# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->

	containerSize = $('.sc-items').data('container-size') + 'px'
	listSort = $('.sc-items').data('sort')
	sortButton = $('.sc-subnav .sort-button')
	$('.sc-items').delay(1000).css('width', containerSize)
	$('.sc-items > li').tsort('',{data:'size', order:'rand'})
	listSort = 'rand'
	sortButton.on "click", () ->
		console.log listSort
		if listSort == 'desc'
			$('.sc-items > li').tsort('',{data:'size', order:'asc'})
			listSort = 'asc'
			sortButton.text('sort large to small')

		else if listSort == 'asc' || 'rand'
			$('.sc-items > li').tsort('',{data:'size', order:'desc'})
			listSort = 'desc'
			sortButton.text('sort small to large')
		console.log listSort

