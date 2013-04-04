// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs

j = jQuery.noConflict();



j(document).ready(function(){
    j(".flash_message").css("height", j(".flash_message").css("height"));
    j(".flash_message").css("color", "red");

    setTimeout('j(".flash_message").css("color", "transparent")', 5000);
    setTimeout('j(".flash_message").css("padding", "0px")', 6200);
    setTimeout('j(".flash_message").css("height", "0px")', 6400);
    setTimeout('j(".flash_message").css("display", "none")', 7600);

    j(".sidebar-block").each(function(){
        j(this).attr("real-height", j(this).css("height"));
        j(this).css("max-height", j(this).css("height"));
    });

    j(".dropdown").click(function(){
        hide_dropdown(j(this));
    });
});

function hide_dropdown(el){
    var list = el.parents(".sidebar-block");
    list.css("max-height", "22px");
    list.find(".arrow-right-icon").removeClass("transformed_arrow");
    el.unbind("click");
    el.click(function(){
        show_dropdown(el);
    });
}

function show_dropdown(el){
    var list = el.parents(".sidebar-block");
    list.css("max-height", list.attr("real-height").toString());
    list.find(".arrow-right-icon").addClass("transformed_arrow");
    el.unbind("click");
    el.click(function(){
        hide_dropdown(el);
    });
}
