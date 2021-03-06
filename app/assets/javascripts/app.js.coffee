# $(document).on 'page:fetch', ->
#   $('body').fadeOut 'slow'
#   $('.collections-menu').hide()

# $(document).on 'page:restore', ->
#   $('body').fadeIn 'slow'

$(document).on "turbolinks:load", ->
	
	# console.log "app.coffee - page change"

	$.cloudinary.responsive()
	$('img.img-responsive').cloudinary_update()

	# $('#collection-items-section .inactive .inactive-button').hide()
	# $('#collection-items-section .active .active-button').hide()

	# TABLE ROW LINKS
	$("tr[data-link]").on "click", -> 
		window.location = this.dataset.link

	# CAROUSEL
	$('.carousel').carousel({
	  interval: 5000
	})

	# DROPDOWN-MENU
	# ('.dropdown-toggle').dropdown('hide')

	$('.dropdown-menu').on "click", (event) ->
		$('.dropdown-menu').dropdown('hide')

	# MAIN MENU
	body = $( 'body' )
	current = -1;
	items = $( '#cbp-hrmenu > ul > li.drop' )
	itemsAll = $( '#cbp-hrmenu > ul > li' )
	menuItems = items.children( 'a' )

	items.on "click", (event) ->
	  event.stopPropagation()
	  # event.preventDefault()

	menuItems.on "click", ( event ) ->
	  itemsAll.eq( current ).removeClass "cbp-hropen" if current != -1
	  item = $( event.currentTarget ).parent( 'li' )
	  idx = item.index()
	  if current == idx
	  	console.log item
	  	item.removeClass( 'cbp-hropen' )
	  	current = -1
	  else
	  	item.addClass( 'cbp-hropen' )
	  	current = idx
	  body.on 'click', ( event ) ->
	  	items.eq( current ).removeClass( 'cbp-hropen' )
	  	current = -1

	# SCROLLING
	$('.scroll').smoothDivScroll autoScrollingMode: "", mousewheelScrolling: "", mousewheelScrollingStep: 1, visibleHotSpotBackgrounds: "always", touchScrolling: true
