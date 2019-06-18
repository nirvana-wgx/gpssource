/** jquery ui 小插件集合**/
(function($) {
	/**
	* 控制下拉框只读
	**/
	$.fn.selectReadOnly=function(){
	    var tem=$(this).children('option').index($(this).find("option:selected"));
	    $(this).change(function(){
	          $(this).children('option').eq(tem).attr("selected",true);
	    });
	}
	
})(jQuery);