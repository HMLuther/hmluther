$(document).on "page:change", ->
	
	body = $( 'body' )
	current = -1;
	items = $( '#cbp-hrmenu > ul > li.drop' )
	itemsAll = $( '#cbp-hrmenu > ul > li' )
	menuItems = items.children( 'a' )
	console.log "page change"
	# console.log items


	items.on "click", (event) ->
	  event.stopPropagation()
	  event.preventDefault()

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




