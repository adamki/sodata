// hover the user card and bike card respectivley
$(document).ready(function(){
  allowHover();
  setupModal();
})

function allowHover(){
  $( ".eight" ).hover(
    function() {
      $( this ).addClass( "hover" );
    }, function() {
      $( this ).removeClass( "hover" );
    }
  );
}

function setupModal(){
  $("#modal-trigger").on("click", function(){
    $('.ui.modal.new-bike')
      .modal('show')
    ;
  })
}

