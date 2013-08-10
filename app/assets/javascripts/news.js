//
//var timeout;
//
//function add_comment_handler(new_comment_url){
//    j("#add_comment").click(function(){
//        if(j("#new_comment").val().trim() != ""){
//            j.ajax({
//                url: new_comment_url,
//                data: {text: j("#new_comment").val()},
//                type: 'POST',
//                beforeSend: function () {
//                },
//                complete: function(){
//                },
//                error: function(err){
//                    alert("error");
//                },
//                success: function(data){
//                    j("#comments").append(data);
//                    j("#new_comment").val("");
//                }
//            });
//        }
//    });
//}
//
//
//j(document).ready(function(){
//    var opts = {
//        cssClass : 'el-rte',
//        lang     : 'ru',
//        height   : 450,
//        toolbar  : 'complete'
//    };
//    j('#news_body').elrte(opts);
//    j('#news_form').submit(function(){
//        var form = j(this);
//        form.find('.attached_image').each(function(){
//            var name = j(this).attr('name');
//            var is_image = false;
//            form.find('iframe').each(function(){
//                j(this.contentWindow.document).find("img[asset='"+name+"']").each(function(){
//                    is_image = true;
//                    j(this).attr('src','');
//                });
//            });
//            if(!is_image){
//                j(this).remove();
//            }
//        });
//        form.find('#news_body').val(form.find('iframe').get(0).contentWindow.document.body.innerHTML);
//        //return false;
//    });
//});
//
