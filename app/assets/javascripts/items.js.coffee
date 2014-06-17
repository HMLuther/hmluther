$(document).on "page:change", ->

	# CATEGORY
	categoryContainerSize = $('.category-items').data('container-size') + 'px'
	listSort = $('.category-items').data('sort')
	sortButton = $('.category-subnav .sort-button')
	displayButton = $('.item-subnav .display-button')
	categoryItems = $('.category-items')
	categoryItemsLi = $('.category-items > li')
	
	categoryItemsLi.tsort('',{data:'size', order:'rand'})

	listSort = 'rand'
	sortButton.on "click", () ->
		console.log listSort
		if listSort == 'desc'
			$('.category-items > li').tsort('',{data:'size', order:'asc'})
			listSort = 'asc'
			sortButton.removeClass('lg-sm-icon').addClass('sm-lg-icon')
			sortButton.text('sort lg > sm')

		else if listSort == 'asc' || 'rand'
			$('.category-items > li').tsort('',{data:'size', order:'desc'})
			listSort = 'desc'
			sortButton.removeClass('sm-lg-icon').addClass('lg-sm-icon')
			sortButton.text('sort sm > lg')
		console.log listSort

	displayButton.on "click", () ->
		alert "Display Button"

	setCategoryItemsWidth = () ->
		if categoryItemsLi.css('margin-bottom') == '20px'
			categoryItems.delay(1000).css('width', categoryContainerSize)

	setCategoryItemsWidth()
	$(window).resize () ->
		if categoryItemsLi.css('margin-bottom') == '20px'
			setCategoryItemsWidth()
		else if categoryItemsLi.css('margin-bottom') == '10px'
			categoryItems.css('width', '100%')

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