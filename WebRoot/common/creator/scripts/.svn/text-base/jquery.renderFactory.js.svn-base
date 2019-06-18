(function($){
	/**
	 * 用可编辑下拉框替换当前对象
	 */
	$.fn.toCombobox = function(opts){
		var opts = opts || {};
		if($(this).is("select")){
			var items = new Array();
			var selectedIndex;
			$.each($(this).find('option'),function(i, item){
				items.push({realValue: ($(item).attr('value') || $(item).html()), displayValue: $(item).html()});
				if(typeof($(item).attr("selected")) != "undefined"){
					selectedIndex = i;
				}
			});
			opts.items = items;
			opts.selectedIndex = selectedIndex;
		}
		if($(this).attr("name")){
			opts.name = $(this).attr("name");
		}
		var combobox = new Combobox(opts);
		$(this).replaceWith(combobox.getElement());
		return combobox;
	};
	
	$.fn.Combobox = function(opts){
		var opts = $.extend(opts, {domElement: this[0]});
		var combobox = new Combobox(opts);
		return combobox;
	};
	
	/**
	 * 增加一个可编辑下拉框子节点
	 */
	$.fn.appendCombobox = function(opts){
		var combobox = new Combobox(opts);
		try{
			$(this).append(combobox.getElement());
		}catch(e){
			window.console.log("append error.");
		}
		return combobox;
	}

})(jQuery);