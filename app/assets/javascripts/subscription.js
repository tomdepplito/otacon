$("#subscription").hide();

$("input:radio[value=true]").click(function() {
  $("#subscription").show();
});

$("input:radio[value=false]").click(function() {
  $("#subscription").hide();
});
