// hover the user card and bike card respectivley
$(document).ready(function(){
  staticAnimations();
  allowHover();
  setupModal();
  deleteModal();
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

function staticAnimations(){
  $('.tiny.image.circular')
    .transition('vertical flip in')
  ;

  $('.icon.bike')
    .transition({
      animation : 'jiggle',
      duration  : 800,
      interval  : 200
    })
  ;
}

function deleteModal(){
  $(".delete.confirmation").on("click", function(){
    $('.modal.delete-bike')
      .modal('show')
    ;
  })
}
