$(document).on "page:change", ->

	# CATEGORY
	categoryContainerSize_1 = $('.category-items').data('container-size-1') + 'px'
	categoryContainerSize_2 = $('.category-items').data('container-size-2') + 'px'
	listSort = $('.category-items').data('sort')
	sortButton = $('.category-subnav .sort-button')
	displayButton = $('.category-subnav .display-button')
	categoryItems = $('.category-items')
	categoryItemsLi = $('.category-items > li')
	listSort = 'rand'
	rowCount = 1
	
	# categoryItemsLi.tsort('',{data:'size', order:'rand'})

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
		if categoryItems.hasClass('two-rows')
			rowCount = 1
			categoryItems.hide()
			setCategoryItemsWidth(rowCount)
			categoryItems.removeClass('two-rows')
			categoryItems.fadeIn(500)
			displayButton.text('Display : 2 rows')
			console.log 'Display Button: 2-rows'
		else
			categoryItems.addClass('two-rows')
			rowCount = 2
			categoryItems.hide()
			setCategoryItemsWidth(rowCount)
			categoryItems.fadeIn(500)
			displayButton.text('Display : 1 row')
			console.log 'Display Button: 1-row'

	setCategoryItemsWidth = (count) ->
		if categoryItemsLi.css('margin-bottom') == '20px' && count == 1
			categoryItems.css('width', categoryContainerSize_1)

		else if categoryItemsLi.css('margin-bottom') == '20px' && count == 2
			categoryItems.css('width', categoryContainerSize_2)

	setCategoryItemsWidth(rowCount)
	$(window).resize () ->
		if categoryItemsLi.css('margin-bottom') == '20px'
			setCategoryItemsWidth(rowCount)
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