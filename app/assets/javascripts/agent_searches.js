$(
  function() {
    $( '.connect-button' ).on( 'click', function() {
      //console.log( "HERE" )
      //console.log( this )
      $(this).attr( 'class', 'connect-button-met' )
      $(this).text( 'Connected' )
    } )
  }
)
