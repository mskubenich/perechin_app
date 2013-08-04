

j(document).ready(function(){
    var opts = {
        cssClass : 'el-rte',
        lang     : 'ru',
        height   : 450,
        toolbar  : 'complete'
    };
    j('#anecdote_body').elrte(opts);
    j('#anecdote_form').submit(function(){
        var form = j(this);
        form.find('.attached_image').each(function(){
            var name = j(this).attr('name');
            var is_image = false;
            form.find('iframe').each(function(){
                j(this.contentWindow.document).find("img[asset='"+name+"']").each(function(){
                    is_image = true;
                    j(this).attr('src','');
                });
            });
            if(!is_image){
                j(this).remove();
            }
        });
        form.find('#anecdote_body').val(form.find('iframe').get(0).contentWindow.document.body.innerHTML);
        //return false;
    });
});
