// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui-1.10.3.custom.min
//= require bootstrap
//= require jquery.scrollTo.min
//= require jquery.tinysort.min
//= require jquery.kinetic.min
//= require jquery.mousewheel.min
//= require jquery.smoothdivscroll-1.3
//= require data-confirm-modal
//= require turbolinks
//= require_tree .

$(function() {
	console.log("loaded!");

	var int = null;
	var int_duration = 10;
	var movement = 5;

	function scollNext(){
		// console.log('hovering...');
		$('.category-items-container').scrollTo( '+=' + movement, { axis: 'x', easing: 'easeInOutCirc' } );
	}

	function scollPrev(){
		// console.log('hovering...');
		$('.category-items-container').scrollTo( '-=' + movement, { axis: 'x', easing: 'easeInOutCirc' } );
	}

	$('.next').hover(function() {
		int = setInterval(scollNext, int_duration);
	}, function() {
		clearInterval(int);
		console.log('finished');
	});

	$('.prev').hover(function() {
		int = setInterval(scollPrev, int_duration);
	}, function() {
		clearInterval(int);
		console.log('finished');
	});


});