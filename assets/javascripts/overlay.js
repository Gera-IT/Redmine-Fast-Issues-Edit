$(function(){

    var clicks = 0;
    $('td.subject').find('a').click(function(e){

       clicks = clicks + 1;
       if (clicks == 1)
       {
           e.preventDefault();
           id = $(this).attr('href').replace( /\/issues\//, '' );
           $.ajax({
               url: "/render_form.js",
               data: {id: id, controller: 'issues', action: 'render_form'},
               dataType: 'script',
               error: function(XMLHttpRequest, textStatus, errorThrown) {
                   alert("Status: " + textStatus); alert("Error: " + errorThrown)}
           })
       }
       else
       {
           return false;
       }



   });





});



