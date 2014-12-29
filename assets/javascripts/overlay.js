$(function(){
    $('td.subject').find('a').live('click', function(e){
         e.preventDefault();
         console.log(e);
         _this = $(this);
         project_id = $('form').first().attr('action').replace( /\/projects\//, '' );
         project_id = project_id.replace( /\/search/, '' );
         id = $(this).attr('href').replace( /\/issues\//, '' );
         $.ajax({
           url: "/render_form.js",
           data: {id: id, project_id: project_id},
           dataType: 'script',
           error: function(XMLHttpRequest, textStatus, errorThrown) {
               window.location = _this.attr('href');
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
                window.location = $('a.new-issue').attr('href');
            }
        })

    });
});

