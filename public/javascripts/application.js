$(function() {
  $("select, input:checkbox, input:radio, input:file").uniform();
  
  $('a.disabled').live('click', function(e) {
    e.preventDefault();
    return false;
  });
});