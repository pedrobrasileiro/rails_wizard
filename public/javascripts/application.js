$(function() {
  $('a.disabled').live('click', function(e) {
    e.preventDefault();
    return false;
  });
});