$(window).scroll( function() {
  $('#flash').css('top', Math.max(0, 50 - $(this).scrollTop()));
});
