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

	if $('input#position').val() == ""
		sortButtonLS.addClass('active')
		sortButtonSL.removeClass('active')
		categoryItemsLi.tsort('',{data:'size', order:'desc'})

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

	# FLASH
	flashDisplay = (msg) ->
		topPos = Math.max($(window).height() / 2 - $('.flash-ajax')[0].offsetHeight / 2, 0)
		leftPos = Math.max($(window).width() / 2 - $('.flash-ajax')[0].offsetWidth / 2, 0)
		$('.flash-ajax').css('top', topPos + "px")
		$('.flash-ajax').css('left', leftPos + "px")
		$('.flash-ajax').css('position', 'fixed')
		$('.flash-ajax').text(msg)
		$('.flash-ajax').fadeIn(250).delay(1500).fadeOut(250)

	# ITEM

	# collectionAddButton = $('.item-subnav .collection-add-button')
	# collectionLoginButton = $('.item-subnav .collection-login-button')
	# collectionMenu = $('.collections-menu')
	# addLoginButton = $('.add-login-button')

	itemLinks.on "click", () ->
		left_position = $('.category-items-container').scrollLeft()
		$('input#position').val(left_position)

	designerLinks.on "click", () ->
		left_position = $('.category-items-container').scrollLeft()
		$('input#position').val(left_position)

	# collectionAddButton.on "click", (event) ->
	# 	event.stopPropagation()
	# 	event.preventDefault()
	# 	if collectionAddButton.hasClass('active')
	# 		collectionMenu.slideUp(200)
	# 		collectionAddButton.removeClass('active')
	# 		console.log 'close add button'
	# 	else
	# 		collectionAddButton.addClass('active')
	# 		collectionMenu.slideDown(200)
	# 		console.log 'open add button'

	# collectionMenu.on "click", (event) ->
	# 	event.stopPropagation()
	# 	collectionMenu.hide()
	# 	collectionAddButton.removeClass('active')
	# 	console.log 'collectionMenu click'

	# collectionLoginButton.on "click", () ->
		# alert "You must login to manage collections"
		# flashDisplay('You must login to manage collections')

	# addLoginButton.on "click", () ->
		# alert "You must login to add items to collections"
		# flashDisplay('You must login to add items to collections')



