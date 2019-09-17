$(document).on "turbolinks:load", ->

	# SET RECENTLY VIEWED ITEMS
	setRecentlyViewed = () ->
		# console.log 'set recently viewed'
		if $.inArray("items", window.location.pathname.split("/")) == 1 || $.inArray("category", window.location.pathname.split("/")) == 1
			# console.log "YEP!"
			$.ajax url: "/set_recently_viewed"
		else
			# console.log "NOPE!"

	setRecentlyViewed()

	# CATEGORY
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
		# categoryItemsLi.tsort('',{data:'size', order:'desc'})
		categoryItemsLi.tsort(order:'rand')

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
		categoryItems.fadeIn(500)
		console.log 'display as 1-row'
		console.log 'rowCount: ' + rowCount

	setCategory2Row = () ->
		categoryItems.hide()
		display2Button.addClass('active')
		display1Button.removeClass('active')
		categoryItems.removeClass('one-row').addClass('two-rows')
		categoryItems.fadeIn(500)
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

	welcomeModal = () ->
		if $.inArray("category", window.location.pathname.split("/")) == 1
			console.log 'CATEGORY'
			if $.cookie('hml_category')
				console.log 'YES WELCOME COOKIE: ' + $.cookie("hml_category")
				# $.removeCookie("hml_category", {path: "/", domain: "hml-prod.herokuapp.com"})
			else
				console.log 'NO WELCOME COOKIE: ' + $.cookie("hml_category")
				$.cookie("hml_category", "1", {path: "/", domain: "hmluther.com"})
				$.cookie("hml_category", "1", {path: "/", domain: "hml-prod.herokuapp.com"})
				$.cookie("hml_category", "1", {path: "/", domain: "hml-dev.herokuapp.com"})
				$.cookie("hml_category", "1", {path: "/", domain: "localhost"})
				$('.welcome_modal').modal()
		else
			console.log 'NOT CATEGORY'

	$('#welcome_modal').on "hidden.bs.modal", () ->
		$('#welcome_modal').remove('.welcome_modal')
		# alert "modal hidden"

	setRowDisplay()
	setCategoryItemsContainerPosition()
	welcomeModal()
	

	# ITEM
	itemLinks.on "click", () ->
		left_position = $('.category-items-container').scrollLeft()
		$('input#position').val(left_position)

	designerLinks.on "click", () ->
		left_position = $('.category-items-container').scrollLeft()
		$('input#position').val(left_position)





