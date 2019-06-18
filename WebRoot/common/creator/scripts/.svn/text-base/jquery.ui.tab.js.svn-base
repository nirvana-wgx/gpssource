/*
 * 标签控件
 * Name : tab 
 * version : 1.0
 * Date : 1st August 2012
 * update : 21th January 2013
 * Written by : Jian.Hou
 */

/* ================================================================ */
(function($) {
/* ================================================================ */
	//$.tab对象
	$.tab = {
		// ------------ default setting ------------------ //
		setting : {
			tabClass : 			'.tabs_group',
			prevButton : 		'.tabs_leftarrow a',
			nextButton : 		'.tabs_rightarrow a',
			prevButtonStatus :  'freeze',
			nextButtonStatus :  '',
			initializing : 		true, //初始化 
			slideSpace :  		120, //滑动幅度
			spacing : 			0, //滑动之前的左边距离
			rightBtnSapcing :	10,
			initTime : 			400, //初始化滑动时间
			slidingTime :  		400, //滑动时间
			fadeTime : 			300
		},

		//extend
		extend : function(opts) {
			return $.extend(this.setting, {}, opts);	
		},//end
		
		// ------------ helper methods ---------------- //

		//遍历tab的tab子项，得到tab的总宽度
		getTabWidth : function(tab) {
			var tabItems = tab.children(),
				width = 0,
				i,
				len = tabItems.length;

			for (i = 0; i < len; i += 1) {
				width += $(tabItems[i]).outerWidth(true);
				//console.log($(tabItems[i]).outerWidth() + parseInt($(tabItems[i]).css('marginRight')));
			}
		//	console.log(tab);
			tab.css('width', width + 'px');
			width = tab.outerWidth();
		//	console.log(width);
			return width;
		},//end

		// ------------ main methods ------------------ //
		//判断按钮的状态移改变对应的class
		toggleStatus : function(button, buttonStatus) {	
			if (buttonStatus === 'freeze') {
				button.addClass('freeze');
			} else if (buttonStatus === 'unfreeze') {	
				button.removeClass('freeze');
			}	
		},
		
		//封装按钮状态处理方法
		changeBtnStatus : function(prevButton, nextButton) {
			var setting = this.setting;
			this.toggleStatus(prevButton, setting.prevButtonStatus);
			this.toggleStatus(nextButton, setting.nextButtonStatus);
		},

		//按钮隐藏
		reset : function(tab) {
			//初始移动变量
			var posX,
				setting = this.setting;

			//不滑动时复位
			posX = setting.spacing;
				 
			tab.animate({
				left: posX + 'px'
				}, 	
				setting.initTime
			);				
		}, //end

		//按钮显示
		showBtn : function(tab, distance, prevButton, nextButton) {
			//初始移动变量
			var posX,
				tabFunc = this,
				setting = this.setting;
			//初始化	
			if (setting.initializing === true) {
				//rightBtnSapcing修补左边元素
				posX = distance + setting.rightBtnSapcing;
				tab.animate({
					left: -posX + 'px'
					}, 
					setting.initTime,
					function() {
						tabFunc.changeBtnStatus(prevButton, nextButton);
					}
				);
			}
			//返回UL移动的真实参数
			return -posX;
		}, //end

		//
		leftMove : function(posX, tab, distance, prevButton, nextButton) {
			//初始移动变量
			var tabFunc = this,
				setting = this.setting;
			if ( (distance + posX) / setting.slideSpace < 1) {					
				posX = - distance - setting.rightBtnSapcing;
				setting.prevButtonStatus = 'freeze';
			} else if ( (distance + posX) / setting.slideSpace >= 1) {
				posX -= setting.slideSpace;
				setting.prevButtonStatus = 'unfreeze';
			}								
			tab.animate({
				left: posX + 'px'
				}, setting.time,
				function() {
					setting.nextButtonStatus = 'unfreeze';
					tabFunc.changeBtnStatus(prevButton, nextButton);
				}
			);
			return posX;
		}, //end

		//
		rightMove : function(posX, tab, prevButton, nextButton) {
			//初始移动变量
			var tabFunc = this,
				setting = this.setting;
			if (posX / setting.slideSpace > -1) {
				posX = setting.rightBtnSapcing;
				setting.nextButtonStatus = 'freeze';
			} else if (posX / setting.slideSpace <= -1) {
				posX += setting.slideSpace;				
				setting.nextButtonStatus = 'unfreeze';
			}		
			tab.animate({
				left: posX + 'px'
				}, setting.time,
				function() {
					setting.prevButtonStatus = 'unfreeze';
					tabFunc.changeBtnStatus(prevButton, nextButton);
				}
			);
			return posX;
		}, //end
		
		//eventProxy args = {event: {eventMethods: function(){}} }
		eventProxy : function(element, options, args) {
			var tab = element.find(options.tabClass),
				tabItems = tab.children(),
				args = args || {},
				propetys = [],
				array = [],
				i = 0;
	
			for (propetys in args) {
				var event = array[i] = propetys;
				if (event === 'contextmenu') {
					this.event(tabItems, 'contextmenu', args);
				}
				if (event === 'click') {
					this.event(tabItems, 'click', args);
				}											
				i ++;			
			}
		}, //end		

		//event bound
		event : function(tabItems, event, args) {	
			tabItems.each( function() {
				$(this).off(event);
				$(this).on(event, function(evt) {
					var eMethods = args[event];	
					if (typeof eMethods !== 'function') {return;}
					eMethods(this, evt); 
					return false;
				});
			});	
		},
		//end	
		
		init : function(element, opts) {
			var tabFunc = this,
				options = this.extend(opts),
				tab = element.find(options.tabClass),
				width = this.getTabWidth(tab),
				parent = tab.parent(),
				parentW = parent.width(),
				distance = width - parentW,	
				posX = 0,			
				prevButton = element.find(options.prevButton),
				nextButton = element.find(options.nextButton); 
			if (distance > 0) {				
				prevButton.fadeIn(options.fadeTime);
				nextButton.fadeIn(options.fadeTime);
				posX = this.showBtn(tab, distance, prevButton, nextButton);
				
				prevButton.off('click');
				prevButton.on('click', function(event) {
					stopPropagation(event);
					posX = tabFunc.leftMove(posX, tab, distance, prevButton, nextButton);
					return false;
				});

				nextButton.off('click');
				nextButton.on('click', function(event) {
					stopPropagation(event);	
					posX = tabFunc.rightMove(posX, tab, prevButton, nextButton);			
					return false;
				});
			} else {
				prevButton.fadeOut(options.fadeTime);
				nextButton.fadeOut(options.fadeTime);
				this.reset(tab);
				tab.css('width', parentW + 'px');
			}
		} //end		
	};
	//end

	//jQuery对象方法
	$.fn.tab = function(func, opts, args) {
		var args = args || {};
			
		if (typeof func !== 'string') {return;}
		if (func === 'init') {
			$.tab.init(this, opts);
		}
		if (func === 'resize') {
			$.tab.resize(this, opts);
		}	
		if (func === 'eventProxy') {
			$.tab.eventProxy(this, opts, args);
		}
	};
	//end

/* ================================================================ */
})( jQuery );
/* ================================================================ */