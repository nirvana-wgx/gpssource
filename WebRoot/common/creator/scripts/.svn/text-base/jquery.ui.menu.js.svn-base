(function($){
	/**
	* 在调用bindMenu的jquery对象上绑一个菜单，单击对象的时候触发菜单的显示隐藏，点击菜单项，触发菜单项上定义的事件
	* 菜单被添加到该对象节点的父节点下
	**/
	$.fn.bindMenu = function(opts){
		var def = {
			items : [], //{displayValue:"", realValue:"", callbackFunc:func}
			selectedIndex : -1,
			showIcon : true,
			showSeparate : false,
			className : 'menu',
			optionClass : 'menu_li',
			labelClass : 'menu_li_label',
			iconClass : 'menu_li_icon',
			separateClass :'menu_li_sep',
			menuWidth: null,
			maxHeight: 100
		};
		
		
		var init = function(){
			menu = $(parent).createDropdownList(options);
			menu.hide();
			$(trigger).bind("click", function(event){
				var event = event || window.event;
				stopPropagation(event);
				var x,y;
				if($(parent).css("position")==="absolute"){
					if($(this).css("position")==="absolute"){
						x = parseInt($(this).css(left));
						y = parseInt($(this).css(top))+$(this).height();
					}else{
						x = this.getBoundingClientRect().left - parent.getBoundingClientRect().left;
						y =  $(this).height()+$(this).offset().top - parent.getBoundingClientRect().top;
					}
				}else{
					x = this.getBoundingClientRect().left;
					y = $(this).height()+$(this).offset().top;
				}
				menu.setPosition(x,y);
				if(options.menuWidth){
					menu.setWidth(options.menuWidth);
				}
				menu.toggle();
			});
			var valueMap ={};
			for(var i=0,len=options.items.length;i<len;i++){
				valueMap[options.items[i].realValue || options.items[i].displayValue] = options.items[i].callbackFunc;
			} 
			//bind event
			menu.dropdownList.bind('selectChange', function(event){//选择菜单项后，执行对应的方法
				menu.hide();
				valueMap[menu.getSelectedRealValue()](menu.getSelectedRealValue());
			});
		};
		
		var parent = $(this).parent()[0],
			trigger = this,
			menu,
			options = $.extend(def, opts);
		var ddList = init();
	};
})(jQuery)