$(document).ready( function() {

  $(window).scroll( function() {
    $('#flash').css('top', Math.max(0, 50 - $(this).scrollTop()));
  });

  var flashTimeout;
  clearTimeout(flashTimeout);
  $('#flash').show();
  flashTimeout = setTimeout( function() {
    $('#flash').slideUp(250);
  }, 2000);
});
