# $(document).on 'page:fetch', ->
#   $('body').fadeOut 'slow'
#   $('.collections-menu').hide()

# $(document).on 'page:restore', ->
#   $('body').fadeIn 'slow'


$(document).on "page:change", ->
	
	console.log "app.coffee - page change"

	# TABLE ROW LINKS
	$("tr[data-link]").on "click", -> 
		window.location = this.dataset.link

	# CAROUSEL
	$('.carousel').carousel({
	  interval: 2000
	})

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

