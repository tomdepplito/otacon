$(document).on('click', '.add_file', function(){
  lastId = parseInt($('li.file_upload').last().attr('id'));
  id = lastId + 1;
  $('li.file_upload').last().append("<li class='file_upload', id='" + id + "'><br><input id='rfi_attachments_attributes_" + id + "_attachment' name='rfi[attachments_attributes][" + id + "][attachment]' type='file'><br></li>");
});
