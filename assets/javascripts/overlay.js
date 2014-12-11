$(function(){
    $('td.subject').find('a').live('click', function(e){
       e.preventDefault();

       id = $(this).attr('href').replace( /\/issues\//, '' );
       $.ajax({
           url: "/render_form.js",
           data: {id: id},
           dataType: 'script',
           error: function(XMLHttpRequest, textStatus, errorThrown) {
               window.location = $(this).attr('href');
               }
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
                console.log(textStatus);
                console.log(errorThrown);
                //window.location = $(this).attr('href');
            }
        })

    });
});

