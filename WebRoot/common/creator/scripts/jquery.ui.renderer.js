(function($) {
	/**
	 * ======================================================
	 * 下拉列表
	 * ======================================================
	 */
	DropdownList = function(opts){
		var def = {
				id: null,
				name: null,
				items : [],
				selectedIndex : -1,
				showIcon : false,
				showSeparate : false,
				className : 'comboboxlist',
				optionClass : 'comboboxlist_li',
				labelClass : 'comboboxlist_li_label',
				iconClass : 'comboboxlist_li_icon',
				separateClass :'comboboxlist_li_sep'
			};
		
		var isShow = false;
		
 // -------------------public方法：begin------------------------
		this.getId = function(){
			return _id;
		};
		
		this.toggle = function(){
			if(isShow){
				this.hide();
			}else{
				this.show();
			}
		};
		this.show = function(){
			$(ddList).show();
			$(document).bind("click", _self.hide);
			isShow = true;
			if($(ddList).height()==0){
				measure();
			}
		};
		this.hide = function(){
			$(ddList).hide();
			$(document).unbind("click", _self.hide);
			isShow = false;
		};
		
		this.getSelectedItem = function(){
			return (selectedIndex == -1) ? null : menuItems[selectedIndex];
		};
		this.getSelectedDisplayValue = function(){
			return this.getItemDisplayValue(selectedIndex);
		};
		this.getSelectedRealValue = function(){
			return this.getItemRealValue(selectedIndex);
		};
		
		this.setSelectedIndex = function(index){
			if(index==-1){
				$(ddList).find('li.'+options.optionClass+'_selected').removeClass(options.optionClass+'_selected');
				$(ddList).find('span.'+options.iconClass+'_selected').removeClass(options.iconClass+'_selected');
				selectedIndex = index;
				$(ddList).trigger('selectChange',[{selectedValue: $(this).attr("value")}]);
			}else{
				$(ddList).find("li:eq("+index+")").trigger("click");
			}
		};
		
		//设置菜单项
		this.setItems = function(items){
			menuItems = items;
			//替换dom
			var _root = $("#"+_id).find("ul");
			$(_root).empty();
			appendMenuItems(_root, menuItems);
			selectedIndex = -1;
			measure();
		};
		//增加菜单项
		this.appendItems = function(items){
			menuItems = menuItems.concat(items);
			var _root = $("#"+_id).find("ul");
			appendMenuItems(_root, items);
			measure();
		};
		//删除菜单项
		this.removeItems = function(items){
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
		
		this.getItemDisplayValue = function(index){
			if(index==-1){
				return null;
			}
			return menuItems[index].displayValue || menuItems[index].realValue || menuItems[index];
		};
		this.getItemRealValue = function(index){
			if(index==-1){
				return null;
			}
			return menuItems[index].realValue || menuItems[index].displayValue || menuItems[index];
		}; 
		
		this.setWidth= function(width){
			var innerW = width;
			if($(ddList).css('border-right-style') != "none"){
				innerW -= parseInt($(ddList).css('border-right-width')) || 0;
			}
			if($(ddList).css('border-left-style') != "none"){
				innerW -= parseInt($(ddList).css('border-left-width')) || 0;
			}
			innerW -= parseInt($(ddList).css('padding-left')) || 0;
			innerW -= parseInt($(ddList).css('padding-right')) || 0;
			$(ddList).css({ 'width': innerW+"px" });
		};
		this.setHeight= function(height){
			var innerH = height;
			if($(ddList).css('border-top-style') != "none"){
				innerH -= parseInt($(ddList).css('border-top-width')) || 0;
			}
			if($(ddList).css('border-bottom-style') != "none"){
				innerH -= parseInt($(ddList).css('border-bottom-width')) || 0;
			}
			innerH -= parseInt($(ddList).css('padding-top')) || 0;
			innerH -= parseInt($(ddList).css('padding-bottom')) || 0;
			$(ddList).css({ 'height': innerH+"px" });
		};
		this.setPosition = function(x, y){
			$(ddList).css({
				'top':y+"px",
				'left':x+"px"
			});
		};
		
		this.getElement = function(){
			return ddList;
		}
 // -------------------public方法：end------------------------
		
		var measure = function(){
			var h;
			if(menuItems && menuItems.length>0){
				if($(ddList).is(":hidden")){
					h = menuItems.length * parseInt($(ddList).find('ul').find("li:first").css("line-height"));
				}else{
					h = parseInt($(ddList).find('ul').css('height'));
				}
				
			}else{
				h = 20;
			}
			$(ddList).css({ 'height': (options.maxHeight ? Math.min(h, options.maxHeight) : h)+"px" });
		};
		/**
		* 创建元素
		**/
		var createElement = function(opts){
			var d = new Date();
			_id = opts.id || "ddList_"+d.getTime()+"_"+parseInt(Math.random()*1000);
			$(document.body).append("<div id='"+_id+"' class='"+opts.className+"'style='position:absolute;'><ul></ul></div>");
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
					$(ddList).trigger('selectChange',[{selectedValue: $(this).attr("value")}]);
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
					$(ddList).trigger('selectChange',[{selectedValue: $(this).attr("value")}]);
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
		
		var init = function(){
			createElement(options);
			//下拉菜单
			ddList = $("#"+_id);
			if(selectedIndex !=-1){
				_self.setSelectedIndex(selectedIndex);
			}
			measure();
		};
		var _self = this,
			options = $.extend(def, opts),
		//数据集
			menuItems = options.items,
			selectedIndex = options.selectedIndex,
			_id, ddList;
		init();
	};
	
	/**
	 * ====================================================
	 * 可编辑下拉框
	 * ====================================================
	 */
	Combobox = function(opts){
		var def = {
				id:null,
				className : 'combobox',
				items:null,
				editable : false,
				value: null,
				selectedIndex: -1,
				value:null,
				width : null,
				height : null,
				domElement: null
	//			ddListMaxHeight: 180
			};
	//	 -------------------public方法：begin------------------------

		this.setItems = function(items){
			menuItems = items;
			if(ddList){
				ddList.setItems(items);
			}else{
				addDDList();
			}
		};
		this.appendItems = function(items){
			if(!items || items.length==0){
				return;
			}
			menuItems = menuItems.concat(items);
			if(ddList){
				ddList.appendItems(items);
			}else{
				addDDList();
			}
		};
		this.removeItems = function(items){
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
			
			if(!this.getSelectedItem()){
				$(element).find('input').val("");
			}
		};
		this.getSelectedItem = function(){
			return ddList ? ddList.getSelectedItem() : null;
		};
		
		this.getValue = function(){
			return _value;
		};
		
		this.setValue = function(value){
			_value = value;
			var label = value, inList = false;
			for(var i=0; i< menuItems.length; i++){
				if(menuItems[i].realValue && value==menuItems[i].realValue){
					ddList.setSelectedIndex(i);
					label = menuItems[i].displayValue;
					inList = true;
					break;
				}
			}
			if(!inList){
				ddList.setSelectedIndex(-1);
			}
			$(input).val(label);
		};
		
		this.setSelectedIndex = function(index){
			if(menuItems.length > index){
				ddList.setSelectedIndex(index);
				_value = menuItems[index].realValue;
				$(element).find('input').val( menuItems[index].displayValue);
			}
		};
		
		this.setWidth = function(width){
			$(element).css({width: width+'px'});
			ddList.setWidth(width);
		};
		this.setHeight = function(height){
			$(element).css({height: height+'px'});
			var icon = $(element).find("."+options.className + "_btn");
			$(input).css({height: height+'px'});
			$(icon).css({height: height+'px'});
		};
		this.setPosition = function(x, y){
			$(element).css({top: y+'px', left: x+'px'});
			positionDDList();
		};
		
		this.getElement = function(){
			return element;
		};
	//	 -------------------public方法：end------------------------
		var positionDDList = function(){
			var rect = element.getBoundingClientRect(), bodyHeight = document.documentElement.clientHeight;
			var X= rect.left+document.documentElement.scrollLeft;            
			var Y =rect.top+document.documentElement.scrollTop;
			if(rect.bottom+$(ddList.getElement()).outerHeight()>bodyHeight){
				//下面空间不够出下拉菜单
				if(rect.top > bodyHeight-rect.bottom){//上面空间大于下面空间，菜单出在上面
					if(rect.top > $(ddList.getElement()).outerHeight()){//上面空间足够出菜单
						Y -= $(ddList.getElement()).outerHeight();
					}else{//空间不够，改变菜单高度
						ddList.setHeight(Y);
						Y = 0;
					}
				}else{//菜单出在下面, 改变菜单的高度
					ddList.setHeight(bodyHeight-rect.bottom);
					Y += $(element).outerHeight();
				}
			}else{
				//向下出下拉菜单
				Y += $(element).outerHeight();
			}
			ddList.setPosition(X, Y);
		};
		var addDDList = function(){
			ddList = new DropdownList({items: menuItems, selectedIndex : options.selectedIndex, maxHeight: options.ddListMaxHeight});
			//bind event
			ddList.getElement().on('selectChange', function(){
				var text = ddList.getSelectedDisplayValue();
				if(text){
					$(input).attr('value',text);
					_value = ddList.getSelectedRealValue();
		/**			$(input).trigger("change"); //不能再触发input的change了，否则会使得getValue的值是显示的值而不是下拉项的真实值 */
				}
				ddList.hide();
				$(element).trigger("change");
			});
		};
		
		var init = function(){
			var cls = options.className,
				inputCls = options.className + "_input",
				iconCls = options.className + "_btn",
				icon;
			if(options.domElement){
				element = options.domElement;
			}else{
				var d = new Date(),
					id = options.id || 'combobox_'+d.getTime();
				$(document.body).append("<div class='"+options.className+"' id='"+id
								+"'><div class='"+options.className+"_box'><input type='text' class='"+inputCls+"' /><span class='"+iconCls+"' /></div></div>");
				element = $(document).find("#"+id)[0];
			}
			//------------------------------
			input = $(element).find("input."+inputCls)[0];
			icon = $(element).find("."+iconCls)[0];
			$(input).attr('name', options.name);
			if(!options.editable){
				$(input).attr('readonly', 'readonly');
				$(input).addClass(inputCls+'_readonly');
			}
			//------------------------------
			//position and size
			if(options.width){
				_self.setWidth(options.width);
			}
			if(options.height){
				$(element).css({height: options.height+'px'});
				$(input).css({height: options.height+'px'});
				$(icon).css({height: options.height+'px'});
			}
			if(options.selectedIndex!=-1 || options.value){
				addDDList();
				ddList.hide();
				if(options.selectedIndex!=-1){
					_self.setSelectedIndex(options.selectedIndex);
				}
				if(options.value){
					_self.setValue(options.value);
				}
			}
			
			$(element).find("span."+iconCls).on("click", function(event){
				var event = event || window.event;
				stopPropagation(event);
				if(!ddList){
					addDDList();
					ddList.hide();
				}
				ddList.setWidth($(element).outerWidth());
				positionDDList();
				ddList.toggle();
			});
			$(input).on('change', function(){
				if(ddList){
					ddList.setSelectedIndex(-1);
				}
				_value = $(this).val();
				$(element).trigger("change");
			});
			
			
		};
		
		//类的内部变量
		var _self = this,
			options = $.extend(def, opts),
			menuItems = options.items,
			ddList,
			input,
			selectedIndex,
			_value=null,
			element;
		init(); 
	};

})(jQuery);