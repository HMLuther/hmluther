$(document).on "page:change", ->

	# CATEGORY
	categoryContainerSize_1 = $('.category-items').data('container-size-1') + 'px'
	categoryContainerSize_2 = $('.category-items').data('container-size-2') + 'px'
	listSort = $('.category-items').data('sort')
	sortButtonSL = $('.category-subnav .sort-button-sl')
	sortButtonLS = $('.category-subnav .sort-button-ls')
	display1Button = $('.category-subnav .display-1-button')
	display2Button = $('.category-subnav .display-2-button')
	categoryItems = $('.category-items')
	categoryItemsLi = $('.category-items > li')
	designerLinks = $('.category-items-container a')
	itemLinks = $('.item-link')
	listSort = 'rand'
	inputPosition = $('input#position')
	categoryItemsContainer = $('.category-items-container')
	rowCount = ""

	# categoryItemsLi.tsort('',{data:'size', order:'rand'})
	

	sortButtonSL.on "click", () ->
		sortButtonSL.addClass('active')
		sortButtonLS.removeClass('active')
		categoryItemsLi.tsort('',{data:'size', order:'asc'})

	sortButtonLS.on "click", () ->
		sortButtonLS.addClass('active')
		sortButtonSL.removeClass('active')
		categoryItemsLi.tsort('',{data:'size', order:'desc'})

	display1Button.on "click", () ->
		setCategory1Row()

	display2Button.on "click", () ->
		setCategory2Row()

	setCategoryItemsWidth = () ->
		if categoryItemsLi.css('margin-bottom') == '20px' && display1Button.hasClass('active')
			categoryItems.css('width', categoryContainerSize_1)

		else if categoryItemsLi.css('margin-bottom') == '20px' && display2Button.hasClass('active')
			categoryItems.css('width', categoryContainerSize_2)

		else if categoryItemsLi.css('margin-bottom') == '20px' && !display1Button.hasClass('active')
			categoryItems.css('width', categoryContainerSize_1)
			console.log 'setCategoryItemsWidth set to 1'

	setCategoryItemsContainerPosition = () ->
		if inputPosition.val() > 0
			categoryItemsContainer.scrollLeft(inputPosition.val())
			console.log inputPosition.val()

	setCategory1Row = () ->
		categoryItems.hide()
		display1Button.addClass('active')
		display2Button.removeClass('active')
		categoryItems.removeClass('two-rows').addClass('one-row')
		# setCategoryItemsWidth()
		categoryItems.fadeIn(400)
		console.log 'display as 1-row'
		console.log 'rowCount: ' + rowCount

	setCategory2Row = () ->
		categoryItems.hide()
		display2Button.addClass('active')
		display1Button.removeClass('active')
		categoryItems.removeClass('one-row').addClass('two-rows')
		# setCategoryItemsWidth()
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
	# setCategoryItemsWidth()
	setCategoryItemsContainerPosition()

	$(window).resize () ->
		if categoryItemsLi.css('margin-bottom') is '20px'
			setCategoryItemsWidth()
		else if categoryItemsLi.css('margin-bottom') is '10px'
			categoryItems.css('width', '100%')

	# FLASH
	flashDisplay = (msg) ->
		$('.flash-ajax').text(msg)
		$('.flash-ajax').fadeIn(500).delay(2000).fadeOut(500)

	# ITEM
	shareButton = $('.item-subnav .share-button')
	reqInfoButton = $('.item-subnav .request-info-button')
	tearsheetButton = $('.item-subnav .tearsheet-button')
	collectionAddButton = $('.item-subnav .collection-add-button')
	collectionLoginButton = $('.item-subnav .collection-login-button')
	collectionMenu = $('.collections-menu')
	addLoginButton = $('.add-login-button')

	itemLinks.on "click", () ->
		left_position = $('.category-items-container').scrollLeft()
		$('input#position').val(left_position)

	designerLinks.on "click", () ->
		left_position = $('.category-items-container').scrollLeft()
		$('input#position').val(left_position)

	shareButton.on "click", () ->
		alert "Share Button"

	reqInfoButton.on "click", () ->
		alert "Request Info Button"

	tearsheetButton.on "click", () ->
		alert "Tearsheet Button"

	collectionAddButton.on "click", (event) ->
		event.stopPropagation()
		event.preventDefault()
		if collectionAddButton.hasClass('active')
			collectionMenu.slideUp(200)
			collectionAddButton.removeClass('active')
			console.log 'close add button'
		else
			collectionAddButton.addClass('active')
			collectionMenu.slideDown(200)
			console.log 'open add button'

	collectionMenu.on "click", (event) ->
		event.stopPropagation()
		collectionMenu.hide()
		collectionAddButton.removeClass('active')
		console.log 'collectionMenu click'

	collectionLoginButton.on "click", () ->
		# alert "You must login to manage collections"
		flashDisplay('You must login to manage collections')

	addLoginButton.on "click", () ->
		# alert "You must login to add items to collections"
		flashDisplay('You must login to add items to collections')



