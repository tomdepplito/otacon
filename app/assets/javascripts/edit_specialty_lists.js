$(document).on('click', '.electronics', function(){
  $.ajax({url: '/specialty_lists/' + userId, data:"delete_id=" + this.id, type: "DELETE"});
  $('#' + this.id).hide();
});
