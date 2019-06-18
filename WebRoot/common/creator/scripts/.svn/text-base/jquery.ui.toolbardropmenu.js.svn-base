/* ------------------------------------------------------------------
 * 图标按钮显示隐藏
 * Name : toolbarDropMenu 
 * version : 1.0beta
 * Date : 9th November 2012
 * update : 9th November 2012
 * Written by : Jian.Hou
 * -------------------------------------------------------------------
 */
/* ================================================================ */
(function($) {
/* ================================================================ */
$.toolbarDropMenu = {	
	// ------------ default setting ------------------ //	
	setting : {
		widgetWidth : 196
	}, //end

	//extend
	extend : function(opt) {
		return $.extend(this.setting, opt, {});
	}, //end

	//获得显示的区域
	showRegion : function($toolbar, width) {
		var $icoBtns = $toolbar.children('a'),
			toolbar = $toolbar[0],
			totalW = 0,
			result,icoBtn,i;
					
		for (i = 0; i < $icoBtns.length; i++) {
			icoBtn = $icoBtns[i];
			//当可显区域和按钮宽度之和的差小于当前的按钮宽度时返回更多按钮的起始位置
			result = width - totalW;
			if (result > $(icoBtn).width()) {
				totalW += $(icoBtn).width();
				toolbar.index = 0;
			} else {	
				toolbar.index = i;//隐藏按钮开始的位置
				break;
			}		
		}
	}, //end

	//显示/复位弹出按钮
	showBtn : function($toolbar) {
		var toolbar = $toolbar[0],
			$icoBtns,
			$icoBtn,
			cloneBtns;
		//显示more按钮，隐藏按钮组同时改变状态toolbar.status为true
		if (toolbar.index && toolbar.index > 0) {
			var index = toolbar.index,
			    $icoBtns = $toolbar.find('a').slice(index),				
			    $icoBtn = $toolbar.find('a').eq(index),
				cloneBtns = $icoBtns.clone(true),
				moreHtml = '<span class="toolbar_btn"><span class="toolbar_btn_ico toolbar_btn_more"></span></span>';
			$icoBtns.hide();
			$icoBtn.before(moreHtml);
			toolbar.status = true;
		  //当toolbar.status为true，toolbar.index为0时表示需要复原按钮
		} else if (toolbar.status && toolbar.index === 0) {
			$icoBtn.prev().remove();
			$icoBtns.show();
			cloneBtns = null;
		}
		return cloneBtns;
	}, //end

	//显示菜单
	parseBtn : function(elements) {
		var i,
			text,
			str;
		
		if (!elements) {return;}
		//按钮文本装入链接标签中
		for (i = 0; i < elements.length; i++) {
			var elem = elements[i],
				$elem = $(elem);

			var ico = $elem.find('.toolbar_btn_ico');

			str = ico.attr('class').replace(/toolbar_btn_ico\s+/g, '');

			text = $elem.text();
			$elem.empty();
			$elem.text(text);
			elem.ico = str;
		}
		return elements; 
	}, //end

	//绑定按钮click事件
	event : function(btn, obj) {
		btn.on('click', function(event) {
			var event = event || window.event;
			stopPropagation(event);
			$(this).contextMenu(event, obj, {btnClass: 'toolbar_btn_more',specialMode: true});
		});
	}, //end
	
	//初始化
	init : function($toolbar, opt) {	
		var toolbarW = $toolbar.width(),
			toolbar = $toolbar[0],//获得原生对象
			width = toolbarW - this.setting.widgetWidth,
			btn;

		this.showRegion($toolbar, width);
		var clone = this.showBtn($toolbar);
		btn = $toolbar.find('.toolbar_btn_more').parent();
		var obj = this.parseBtn(clone);
		this.event(btn, obj);
	} //end
};

$.fn.toolbarDropMenu = function(opt) {
	var $toolbar = this.find('.toolbar'),
		options = $.toolbarDropMenu.extend(opt);	
	$.toolbarDropMenu.init($toolbar, options);		
};
/*================================================================*/
})( jQuery );
/*================================================================*/