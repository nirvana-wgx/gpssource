/* ------------------------------------------------------------------
 * Name: widgets 
 * description：模拟input，combobox，radio，checkbox，scrollbar
 * version: 
 * Date: 18th December 2012
 * update: 4th Junuary 2013
 * Written by: Jian.Hou
 * ------------------------------------------------------------------
 */

/* ================================================================ */
(function($) {
/* ================================================================ */
	var widgets = {
		Input: function() {},
		Combobox: function() {},
		Radio: function() {},
		Checkbox: function() {},
		Textarea: function() {},
		Scrollbar: function() {}
	};	

	$.fn.widgets = function(opts) {
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

function inheritPrototype(subType, superType){
	var prototype = object(superType.prototype); //create object
	prototype.constructor = subType; //augment object
	subType.prototype = prototype; //assign object
}

function SuperType(name){
	this.name = name;
	this.colors = ["red", "blue", "green"];
}
SuperType.prototype.sayName = function(){
	alert(this.name);
};
function SubType(name, age){
	SuperType.call(this, name);
	this.age = age;
}
inheritPrototype(SubType, SuperType);
SubType.prototype.sayAge = function(){
	alert(this.age);
};