$(function(){

    selector = $('td.subject').find('a');


    $('window').on('click', selector, function(e) {
        //do something
    });


    $('td.subject').find('a').live('click', function(e){

           e.preventDefault();
           id = $(this).attr('href').replace( /\/issues\//, '' );
           $.ajax({
               url: "/render_form.js",
               data: {id: id},
               dataType: 'script',
               error: function(XMLHttpRequest, textStatus, errorThrown) {
                   alert("Status: " + textStatus); alert("Error: " + errorThrown)}
           })
   });
});


$(function(){

    $('a.new-issue').click(function(e){
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

