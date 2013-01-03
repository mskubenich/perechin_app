// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//= require ./jquery_ui/jquery-ui.min
//= require ./elrte/js/elrte.min
//= require ./elrte/js/i18n/elrte.ru.js


function include(filename)
{
    var head = document.getElementsByTagName('head')[0];

    script = document.createElement('script');
    script.src = filename;
    script.type = 'text/javascript';
    script.onload = function(){
        Galleria.loadTheme('/assets/galleria/themes/classic/galleria.classic.min.js');
        Galleria.run('#galleria');
    };

    head.appendChild(script)
}

function add_comment_handler(new_comment_url){
    j("#add_comment").click(function(){
        if(j("#new_comment").val().trim() != ""){
            j.ajax({
                url: new_comment_url,
                data: {text: j("#new_comment").val()},
                type: 'POST',
                beforeSend: function () {
                },
                complete: function(){
                },
                error: function(err){
                    alert("error");
                },
                success: function(data){
                    j("#comments").append(data);
                    j("#new_comment").val("");
                }
            });
        }
    });
}

j(document).ready(function(){
    if(j("#galleria").length){
        include('/assets/galleria/galleria-1.2.8.min.js?body=1');
    }
    var opts = {
        cssClass : 'el-rte',
        lang     : 'ru',
        height   : 450,
        toolbar  : 'complete',
        cssfiles : ['css/elrte-inner.css']
    };
    j('#editor').elrte(opts);
});

