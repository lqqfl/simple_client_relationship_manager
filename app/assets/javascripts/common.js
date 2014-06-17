$(function(){
  defaultInit();
  $(document).on('page:change', function() {
    defaultInit();
  })
});

function defaultInit(){
  $('#side-menu').metisMenu();
  console.log("defaultInit");
}