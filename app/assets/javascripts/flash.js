$(document).ready( function() {

  $(window).scroll( function() {
    $('#flash').css('top', Math.max(0, 50 - $(this).scrollTop()));
  });

  $('#flash').show().delay(2000).slideUp(250);
});
