$(document).on "page:change", ->

	# CATEGORY
	categoryContainerSize_1 = $('.category-items').data('container-size-1') + 'px'
	categoryContainerSize_2 = $('.category-items').data('container-size-2') + 'px'
	listSort = $('.category-items').data('sort')
	# sortButton = $('.category-subnav .sort-button')
	sortButtonSL = $('.category-subnav .sort-button-sl')
	sortButtonLS = $('.category-subnav .sort-button-ls')
	display1Button = $('.category-subnav .display-1-button')
	display2Button = $('.category-subnav .display-2-button')
	categoryItems = $('.category-items')
	categoryItemsLi = $('.category-items > li')
	listSort = 'rand'
	itemLinks = $('.item-link')
	inputPosition = $('input#position')
	categoryItemsContainer = $('.category-items-container')

	# categoryItemsLi.tsort('',{data:'size', order:'rand'})

	sortButtonSL.on "click", () ->
		sortButtonSL.addClass('active')
		sortButtonLS.removeClass('active')
		categoryItemsLi.tsort('',{data:'size', order:'asc'})

	sortButtonLS.on "click", () ->
		sortButtonLS.addClass('active')
		sortButtonSL.removeClass('active')
		categoryItemsLi.tsort('',{data:'size', order:'desc'})


	# sortButton.on "click", () ->
	# 	console.log listSort
	# 	if listSort == 'desc'
	# 		$('.category-items > li').tsort('',{data:'size', order:'asc'})
	# 		listSort = 'asc'
	# 		sortButton.removeClass('lg-sm-icon').addClass('sm-lg-icon')
	# 		sortButton.text('Small to Large')

	# 	else if listSort == 'asc' || 'rand'
	# 		$('.category-items > li').tsort('',{data:'size', order:'desc'})
	# 		listSort = 'desc'
	# 		sortButton.removeClass('sm-lg-icon').addClass('lg-sm-icon')
	# 		sortButton.text('Large to Small')
	# 	console.log listSort

	display1Button.on "click", () ->
		setCategory1Row()

	display2Button.on "click", () ->
		setCategory2Row()

	setCategoryItemsWidth = () ->
		if categoryItemsLi.css('margin-bottom') == '20px' && display1Button.hasClass('active')
			categoryItems.css('width', categoryContainerSize_1)

		else if categoryItemsLi.css('margin-bottom') == '20px' && display2Button.hasClass('active')
			categoryItems.css('width', categoryContainerSize_2)

	setCategoryItemsContainerPosition = () ->
		if inputPosition.val() > 0
			categoryItemsContainer.scrollLeft(inputPosition.val())
			console.log inputPosition.val()

	setCategory1Row = () ->
		categoryItems.hide()
		display1Button.addClass('active')
		display2Button.removeClass('active')
		categoryItems.removeClass('two-rows')
		setCategoryItemsWidth()
		categoryItems.fadeIn(400)
		console.log 'display as 1-row'
		console.log 'rowCount: ' + rowCount

	setCategory2Row = () ->
		categoryItems.hide()
		display2Button.addClass('active')
		display1Button.removeClass('active')
		categoryItems.addClass('two-rows')
		setCategoryItemsWidth()
		categoryItems.fadeIn(400)
		console.log 'display as 2-row'
		console.log 'rowCount: ' + rowCount

	setRowDisplay = () ->
		if display2Button.hasClass('active')
			rowCount = 2
		else if display1Button.hasClass('active')
			rowCount = 1
		else
			display1Button.addClass('active')
			rowCount = 1
		console.log 'setRowDisplay: rowCount' + rowCount

	setRowDisplay()
	setCategoryItemsWidth()
	setCategoryItemsContainerPosition()

	$(window).resize () ->
		if categoryItemsLi.css('margin-bottom') is '20px'
			setCategoryItemsWidth()
		else if categoryItemsLi.css('margin-bottom') is '10px'
			categoryItems.css('width', '100%')

	# ITEM
	shareButton = $('.item-subnav .share-button')
	reqInfoButton = $('.item-subnav .request-info-button')
	tearsheetButton = $('.item-subnav .tearsheet-button')
	collectionAddButton = $('.item-subnav .collection-add-button')
	collectionLoginButton = $('.item-subnav .collection-login-button')

	itemLinks.on "click", () ->
		left_position = $('.category-items-container').scrollLeft()
		$('input#position').val(left_position)

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