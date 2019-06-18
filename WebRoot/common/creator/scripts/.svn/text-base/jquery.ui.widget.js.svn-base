/* ------------------------------------------------------------------
 * Name: widget 
 * description：模拟input，combobox，radio，checkbox，scrollbar
 * version: 
 * Date: 18th December 2012
 * update: 26th December 2012
 * Written by: Jian.Hou
 * ------------------------------------------------------------------
 */

/* ================================================================ */
(function($) {
/* ================================================================ */
	$.widget = function(element, opts) {
		var defaults = {
			focusClass: 'form_focus', //仿:focus效果的class
			type: 'input', //模拟控件类型
			prefix: 'box',
			radioGroup: 'data-radiogroup'
		}; 
		//扩展设置
		var options = $.extend(defaults, {}, opts),
			prefix = '_' + options.prefix,
			define = {
			radioClass: '.radio' + prefix,
			radioCheckedClass: 'radio' + prefix + '_checked',
			//radioFocusClass: 'radio' + prefix + '_focus',
			checkboxClass: '.checkbox' + prefix,
			checkboxCheckedClass: 'checkbox' + prefix + '_checked'
			//checkboxFocusClass: 'checkbox' + prefix + '_focus'
		};
		//清除当前文档的所有:focus class
		var clearFocus = function() {
			var focusElem = $('.' + options.focusClass);
			focusElem.removeClass(options.focusClass);
		};	
		//添加:focus class
		var addFocus = function(elem) {
			clearFocus();
			elem.addClass(options.focusClass);
		};	
		//事件绑定
		var eventBind = function(tag) {
			var form = element.find(tag),
				formBox = form.parent(),
				readonly = form.attr('readonly');
			//有属性readonly时返回	
			if (readonly === 'readonly') { return; }	
			formBox.on('click',function(event) {
				event.stopPropagation();
				addFocus($(this));
			});	
			return form;
		};
		//事件委托，并且抛出一个自定义事件
		var eventPrexy = function(event) {
			var label = element.parent();
			label.on(event, function(e) { 
				var customEvent = event + 'ed';
				preventDefault(e);
				element.trigger(customEvent);
			});
		};		

		var triggerMethod = function(event, checkedClass) {
			element.bind(event, function() {
				var hiddenItem = $(this).children('input'),
					readonly = hiddenItem.attr('readonly'),
					status = hiddenItem.prop('checked');
				//有属性readonly时返回	
				if (readonly === 'readonly') { return; }	
				//当然是radio控件时，始终保持相同组唯一radio被选中
				//同时单击只能选中不能取消选中
				if (hiddenItem.is(':radio')) {
					var group = hiddenItem.attr(options.radioGroup),
						radios = $('input[' + options.radioGroup + '="' + group + '"]');
					radios.prop('checked', false);
					for (var i = 0; i < radios.length; i++) {
						$(radios[i]).parent().removeClass(checkedClass);
					}
				}	
				$(this).toggleClass(checkedClass);
				hiddenItem.prop('checked', !status);		
			});
		};		
		var input = function(tag) {
			return eventBind(tag);
		};	
		var combobox = function(tag) {
			var form = eventBind(tag),
				btn = form.siblings(),
				combobox = form.parent();		
			btn.on('click',function(event) {
				event.stopPropagation();
				addFocus(combobox);
			});	
			return combobox;
		};
		$(document).on({
			'click': function() {
				clearFocus();
			},
			'contextmenu': function() {
				clearFocus();
			}
		});	
		switch (options.type) {
			case 'combobox': 		
				combobox('input');
				break;
			case 'radio': 	
				eventPrexy('click');	
				triggerMethod('clicked', define.radioCheckedClass);
				break;
			case 'checkbox': 
				eventPrexy('click');	
				triggerMethod('clicked', define.checkboxCheckedClass);
				break;
			default : 
				input(options.type);
		}		
	};

	$.fn.widget = function(opts) {
		this.each(function() {
			$.widget($(this), opts);
		})
	};

	$(function() {
		$('.input').widget();
		$('.textarea').widget({type:'textarea'});
		$('.radio_box').widget({type:'radio'});
		$('.checkbox_box').widget({type:'checkbox'});
	});

/* ================================================================ */
})( jQuery );
/* ================================================================ */