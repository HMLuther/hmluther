$(document).on "page:change", ->

	# CATEGORY
	categoryContainerSize = $('.category-items').data('container-size') + 'px'
	listSort = $('.category-items').data('sort')
	sortButton = $('.item-subnav .sort-button')
	displayButton = $('.item-subnav .display-button')
	$('.category-items').delay(1000).css('width', categoryContainerSize)
	$('.category-items > li').tsort('',{data:'size', order:'rand'})
	listSort = 'rand'
	sortButton.on "click", () ->
		console.log listSort
		if listSort == 'desc'
			$('.category-items > li').tsort('',{data:'size', order:'asc'})
			listSort = 'asc'
			sortButton.removeClass('lg-sm-icon').addClass('sm-lg-icon')
			sortButton.text('sort large to small')

		else if listSort == 'asc' || 'rand'
			$('.category-items > li').tsort('',{data:'size', order:'desc'})
			listSort = 'desc'
			sortButton.removeClass('sm-lg-icon').addClass('lg-sm-icon')
			sortButton.text('sort small to large')
		console.log listSort

	displayButton.on "click", () ->
		alert "Display Button"

	# ITEM
	shareButton = $('.item-subnav .share-button')
	reqInfoButton = $('.item-subnav .request-info-button')
	tearsheetButton = $('.item-subnav .tearsheet-button')
	collectionAddButton = $('.item-subnav .collection-add-button')
	collectionLoginButton = $('.item-subnav .collection-login-button')

	shareButton.on "click", () ->
		alert "Share Button"

	reqInfoButton.on "click", () ->
		alert "Request Info Button"

	tearsheetButton.on "click", () ->
		alert "Tearsheet Button"

	collectionAddButton.on "click", () ->
		alert "Collection Add Button"

	collectionLoginButton.on "click", () ->
		alert "You must login to add items to collections"