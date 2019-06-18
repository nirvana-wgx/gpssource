(function($){
	$.fn.select = function(opts){
		var def = {
			className : 'editable_select',
			items:null,
			editable : false,
			width : null,
			height : null
		};
		
		var getOriginalItems = function(select){
			var items = new Array();
			$.each($(select).find('option'),function(i, item){
				items.push({realValue: ($(item).attr('value') || $(item).html()), displayValue: $(item).html()});
			});
			return items;
		};
		
		var setItems = function(items){
			menuItems = items;
			if(ddList){
				ddList.setItems(items);
			}
		};
		var appendItems = function(items){
			if(!items || items.length==0){
				return;
			}
			menuItems = menuItems.concat(items);
			if(ddList){
				ddList.appendItems(items);
			}
			
		};
		var removeItems = function(items){
			if(!items || items.length==0){
				return;
			}
			var newMenues = new Array();//删除后的菜单数据数组
			var len = items.length;
			var removedItemIndex = new Array();
			for(var i=0; i<menuItems.length;i++){
				for(var j=0; j<len; j++){
					if(menuItems[i]==items[j] || menuItems[i].realValue && menuItems[i].realValue == items[j].realValue){//menuItems[i]是需要删除的项
						removedItemIndex.push(menuItems[i]);
						break;
					}
					if(j==len-1){//menuItems[i]不在删除数组里，将menuItems[i]存到newMenues里
						newMenues.push(menuItems[i]);
					}
				}
			}
			menuItems = newMenues;
			if(ddList){
				ddList.removeItems(items);
			}
			
			if(!getSelectedItem()){
				$(element).find('input').val("");
			}
		};
		var getSelectedItem = function(){
			return ddList ? ddList.getSelectedItem() : null;
		};
		
		var getValue = function(){
			return ddList ? (ddList.getSelectedRealValue() || $(element).find('input').attr('value')) : $(element).find('input').attr('value');
		};
		
		var setValue = function(value){
			for(var i=0; i< menuItems.length; i++){
				if(value==menuItems[i] || value==menuItems[i].realValue || value.realValue && value.realValue == menuItems[i].realValue){
					ddList.setSelectedIndex(i);
					return;
				}
			}
			ddList.setSelectedIndex(-1);
			$(element).find('input').val(value);
		};
		var setSelectedIndex = function(index){
			ddList.setSelectedIndex(index);
		};
		
		var setWidth = function(width){
			$(element).css({width: width+'px'});
			var input = $(element).find("input."+options.className + "_input");
			var icon = $(element).find("."+options.className + "_icon");
			$(input).css({width: width-parseInt($(icon).outerWidth())+'px'});
			ddList.setWidth(width);
		};
		var setHeight = function(height){
			$(element).css({height: height+'px'});
			var input = $(element).find("input."+options.className + "_input");
			var icon = $(element).find("."+options.className + "_icon");
			$(input).css({height: height+'px'});
			$(icon).css({height: height+'px'});
		};
		var setPosition = function(x, y){
			$(element).css({top: y+'px', left: x+'px'});
			if($(element).css("position")=="absolute"){
				ddList.setPosition(0, $(element).outerHeight());
			}else if($(element).css("position")=="relative"){
				ddList.setPosition(x, y+$(element).outerHeight());
			}
		};
		
		var init = function(src, opts){
			var d = new Date();
			var id = opts.id || $(src).attr('id') || 'select'+d.getTime();
			var cls = opts.className;
			var inputCls = opts.className + "_input";
			var iconCls = opts.className + "_icon";
			var parent = $(src).parent();
			var _y = src.getBoundingClientRect().top;
			var _x = src.getBoundingClientRect().left;
			var name = $(src).attr("name");
			$(src).replaceWith("<div class='"+opts.className+"' id='"+id
							+"'><div class='"+opts.className+"_combobox'><input type='text' class='"+inputCls+"' /><span class='"+iconCls+"' /></div></div>");
			var elem = $(parent).find("#"+id)[0];
			var input = $(elem).find("input."+inputCls)[0];
			var icon = $(elem).find("."+iconCls)[0];
			$(input).attr('name', name);
			if(!opts.editable){
				$(input).attr('readonly', 'readonly');
				$(input).addClass(inputCls+'_readonly');
			}
			//position and size
			if($(elem).is(":visible")){
				if(opts.width){
					$(elem).css({width: opts.width+'px'});
					$(input).css({width: opts.width-parseInt($(icon).css('width'))-3+'px'});
				}else{
					$(elem).css({width: $(elem).width()+'px'});
					$(input).css({width: $(elem).innerWidth()-$(icon).outerWidth()-3+'px'});
				}	
			}else{//当容器本身是不显示的情况下，无法获取容器的尺寸，无法设置控件的尺寸，在这种情况下给控件设置一个固定的宽度
				$(elem).css({width: '120px'});
				$(input).css({width: '100px'});
			}
					
			if(opts.height){
				$(elem).css({height: opts.height+'px'});
				$(input).css({height: opts.height+'px'});
				$(icon).css({height: opts.height+'px'});
			}
			
			ddList = $(elem).createDropdownList({items: menuItems});
			ddList.hide();
			
			$(elem).find("span."+iconCls).on("click", function(event){
				var event = event || window.event;
				stopPropagation(event);
				ddList.setWidth($(elem).outerWidth());
				ddList.toggle();
			});
			$(input).on('change', function(){
				if(ddList.getSelectedItem){
					ddList.setSelectedIndex(-1);
				}
				$(elem).trigger("change");
			});
			//bind event
			ddList.dropdownList.on('selectChange', function(){
				var text = ddList.getSelectedDisplayValue();
				if(text){
					$(input).attr('value',text);
					$(input).trigger("change");
				}
				ddList.hide();
				$(elem).trigger("change");
			});
			
			return elem;
		};
		
		//类的内部变量
		var options = $.extend(def, opts);
		var menuItems;
		var ddList;
		var element;
		var selectedItems;
		
		if($(this).is('select')){
			menuItems = getOriginalItems(this);
		}
		if(!menuItems || menuItems.length==0){
			menuItems = options.items;
		}
		element = init($(this)[0], options); 
		return {
			getValue : getValue,
			setValue: setValue,
			setWidth : setWidth,
			setHeight: setHeight,
			setPosition: setPosition,
			setSelectedIndex: setSelectedIndex,
			setItems : setItems,
			appendItems : appendItems,
			removeItems : removeItems
		};
	};

//-------------------------------------------------------------------------------
	/**
	*创建dropdownList
	**/
	$.fn.createDropdownList = function(opts){
		var def = {
			items : [],
			selectedIndex : -1,
			showIcon : false,
			showSeparate : false,
			className : 'dropdownlist',
			optionClass : 'dropdownlist_li',
			labelClass : 'dropdownlist_li_label',
			iconClass : 'dropdownlist_li_icon',
			separateClass :'dropdownlist_li_sep',
			maxHeight: 100
		};
		var isShow = false;
		
		var getId = function(){
			return _id;
		};
		
		var toggle = function(){
			if(isShow){
				hide();
			}else{
				show();
			}
		};
		var show = function(){
			$(ddList).show();
			$(document).bind("click", hide);
			isShow = true;
		};
		var hide = function(){
			$(ddList).hide();
			$(document).unbind("click", hide);
			isShow = false;
		};
		
		var getSelectedItem = function(){
			return (selectedIndex == -1) ? null : menuItems[selectedIndex];
		};
		var getSelectedDisplayValue = function(){
			return getItemDisplayValue(selectedIndex);
		};
		var getSelectedRealValue = function(){
			return getItemRealValue(selectedIndex);
		};
		
		var setSelectedIndex = function(index){
			if(index==-1){
				$(ddList).find('li.'+options.optionClass+'_selected').removeClass(options.optionClass+'_selected');
				$(ddList).find('span.'+options.iconClass+'_selected').removeClass(options.iconClass+'_selected');
				selectedIndex = index;
				$(ddList).trigger('selectChange');
			}else{
				$(ddList).find("li:eq("+index+")").trigger("click");
			}
		};
		
		//设置菜单项
		var setItems = function(items){
			menuItems = items;
			//替换dom
			var _root = $("#"+_id).find("ul");
			$(_root).empty();
			appendMenuItems(_root, menuItems);
			selectedIndex = -1;
			measure();
		};
		//增加菜单项
		var appendItems = function(items){
			menuItems = menuItems.concat(items);
			var _root = $("#"+_id).find("ul");
			appendMenuItems(_root, items);
			measure();
		};
		//删除菜单项
		var removeItems = function(items){
			var newMenues = new Array();//删除后的菜单数据数组
			var len = items.length;
			var removedItemIndex = new Array();
			var newSelectedIndex = selectedIndex;
			for(var i=0; i<menuItems.length;i++){
				for(var j=0; j<len; j++){
					if(menuItems[i]==items[j]){//menuItems[i]是需要删除的项
						removedItemIndex.push(i);
						if(selectedIndex == i){//选中行被删除，重置selectedIndex
							newSelectedIndex = -1;
						}else if(selectedIndex >= i){//选中行在该行的后面，选中行行号-1
							newSelectedIndex --;
						}
						break;
					}
					if(j==len-1){//menuItems[i]不在删除数组里，将menuItems[i]存到newMenues里
						newMenues.push(menuItems[i]);
					}
				}
			}
			//删除菜单项
			for(var k=0; k < removedItemIndex.length; k++){
				$(ddList).find("li:eq("+(removedItemIndex[k]-k)+")").remove();//每删除一个，后面的菜单项的index就要减1
			}
			//重置菜单项数据
			menuItems = newMenues;
			//重置选中行行号
			selectedIndex = newSelectedIndex;
			measure();
		};
		
		var getItemDisplayValue = function(index){
			if(index==-1){
				return null;
			}
			return menuItems[index].displayValue || menuItems[index].realValue || menuItems[index];
		};
		var getItemRealValue = function(index){
			if(index==-1){
				return null;
			}
			return menuItems[index].realValue || menuItems[index].displayValue || menuItems[index];
		}; 
		
		var setWidth= function(width){
			$(ddList).css({ 'width': width+"px" });
		};
		var setHeight= function(height){
			$(ddList).css({ 'height': height+"px" });
		};
		var setPosition = function(x, y){
			$(ddList).css({
				'top':y+"px",
				'left':x+"px"
			});
		};
		
		var measure = function(){
			//菜单中一行的高度
			var h;
			//定位菜单
			if(menuItems && menuItems.length>0){
				h = parseInt($(ddList).find('li').css('height'));
				h = menuItems.length*h+3;
			}else{
				h = 20;
			}
			$(ddList).css({
				'height': Math.min(h, options.maxHeight)+'px'
			});
		};
		
		/**
		* 创建元素
		**/
		var createElement = function(opts){
			var d = new Date();
			_id = "ddList_"+d.getTime()+"_"+parseInt(Math.random()*1000);
			$(parent).append("<div id='"+_id+"' class='"+opts.className+"'style='position:absolute;'><ul></ul></div>");
			var _root = $("#"+_id).find("ul");
			appendMenuItems(_root, menuItems);
		};
		
		var appendMenuItems = function(container, items){
			if(!items || items.length==0){
				return;
			}
			$(container).append(createItemsHtml(items));
			if(menuItems.length==items.length){
				$(container).find('li').on('click', function(event){
					var event = event || window.event;
					stopPropagation(event);
				//修改下拉菜单项的样式
					$(ddList).find('li.'+options.optionClass+'_selected').removeClass(options.optionClass+'_selected');
					$(ddList).find('span.'+options.iconClass+'_selected').removeClass(options.iconClass+'_selected');
					$(this).addClass(options.optionClass+'_selected');
					if(options.showIcon){
						$(this).find('span.'+options.iconClass).addClass(options.iconClass+'_selected');
					}
					selectedIndex = $(this).index();
					//隐藏下拉菜单
					$(ddList).trigger('selectChange');
				});
			}else{
				$(container).find('li:gt('+(menuItems.length-items.length-1)+')').on('click', function(){
					//修改下拉菜单项的样式
					$(ddList).find('li.'+options.optionClass+'_selected').removeClass(options.optionClass+'_selected');
					$(ddList).find('span.'+options.iconClass+'_selected').removeClass(options.iconClass+'_selected');
					$(this).addClass(options.optionClass+'_selected');
					if(options.showIcon){
						$(this).find('span.'+options.iconClass).addClass(options.iconClass+'_selected');
					}
					selectedIndex = $(this).index();
					$(ddList).trigger('selectChange');
				});
			}
			
		};
		
		
		var createItemsHtml = function(items){
			var liList="";
			for(var i=0; i<items.length; i++){
				var str = "<li class='"+options.optionClass+"'>";	
				if(options.showIcon){
					str += "<span class='"+options.iconClass+"'></span>"//图标span
					if(options.showSeparate){
						str += "<span class='"+options.separateClass+"'></span>"
					}
				}
				str +="<span class='"+options.labelClass+"'>"+(items[i].displayValue || items[i].realValue || items[i])+"</span></li>"
				liList += str;
			}
			return liList;
		};
		
		var init = function(opts){
			createElement(opts);
			//下拉菜单
			var ddList = $("#"+_id);
			measure();
			return ddList;
		};
		
		var parent = $(this)[0];
		var options = $.extend(def, opts);
		//数据集
		var menuItems = options.items;
		var selectedIndex = options.selectedIndex;
		var _id;
		var ddList = init(options);
		
		return {dropdownList : ddList, 
				getId : getId,
				toggle : toggle, 
				show : show,
				hide : hide,
				getSelectedItem : getSelectedItem,
				getSelectedDisplayValue : getSelectedDisplayValue,
				getSelectedRealValue : getSelectedRealValue,
				setSelectedIndex : setSelectedIndex,
				setItems : setItems,
				appendItems : appendItems,
				removeItems : removeItems,
				setWidth : setWidth,
				setHeight : setHeight,
				setPosition : setPosition
				};
	};
})(jQuery)