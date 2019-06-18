(function($) {
	
	/**
	//控制只读,调用该方法的是jquery对象，对象必须指定过id，对没有指定id的控件不做处理.
	//在元素的父容器内增加一个与之相同尺寸的半透明div遮住该元素区域
	//@readonly true:只读；false:取消只读控制
	*/
	$.fn.setReadOnly = function(readonly){
		if(typeof this != "object"){
			return;
		}
		for(var i=0; i<this.length; i++){
			var container = $(this).eq(i).parent();
			var targetID = this.eq(i).attr("id");
			if(!targetID || targetID==""){
				continue;
			}
			if(readonly){
				if($(this).eq(i).parent().find(".readOnlyMask[for='"+targetID+"']").length==0){
					var mask = "<div class='readOnlyMask' for='"+targetID+"'"
						+"style='width:"+$(this).eq(i).outerWidth()
						+"px;height:"+$(this).eq(i).outerHeight()
						+"px;top:"+$(this).eq(i).offset().top
						+"px;left:"+$(this).eq(i).offset().left+"px'></div>";
					$(this).eq(i).parent().append(mask);
				}
			}else{
				$(this).eq(i).parent().find(".readOnlyMask[for='"+targetID+"']").remove();
			}
		}
	};
	
})(jQuery);