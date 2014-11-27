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
               data: {id: id},
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


$(function(){

    var clicks = 0;
    $('a.new-issue').click(function(e){

        clicks = clicks + 1;


            e.preventDefault();
            id = $('form').first().attr('action').replace( /\/projects\//, '' );
            id = id.replace( /\/search/, '' );
            $.ajax({
                url: "/render_new_form.js",
                data: {project_id: id},
                dataType: 'script',
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    alert("Status: " + textStatus); alert("Error: " + errorThrown)}
            })

    });
});

