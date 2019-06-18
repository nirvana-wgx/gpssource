/*!
 * name: component
 *
 */
(function( $, undefined ) {
	//名字、基类和原型
	//名字：全局命名.模块.功能
	$.component = function( name, base, prototype ) {
		var namespace = name.split( "." )[ 0 ],
			fullName,
			existingConstructor, 
			constructor,
			basePrototype;

		//取出name的实际字段
		//重组标识符
		name = name.split( "." )[ 1 ];
		fullName = namespace + "-" + name;

		//传入参数没有原型
		//使用基础对象为原型，把构造函数$.Component指向base
		if ( !prototype ) {
			prototype = base;
			base = $.Component;
		}	

		//返回一个boolean值
		//true表示缓存$.data(elem, fullName)的数据存在
		$.expr[ ":" ][ fullName.toLowerCase() ] = function( elem ) {
			return !!$.data( elem, fullName );
		};

		$[ namespace ] = $[ namespace ] || {};

		//保存当前的对象的指针
		existingConstructor = $[ namespace ][ name ];

		//使用nstructor实例化element
		constructor = $[ namespace ][ name ] = function( options, element ) {
			// 如果实例没有_createWidget方法，返回一个constructor的实例对象
			if ( !this._createWidget ) {
				return new constructor( options, element );
			}
			if ( arguments.length ) {
				this._createWidget( options, element );
			}
		};

		// 把保存的existingConstructor扩展为onstructor的静态方法
		$.extend( constructor, existingConstructor, {
			version: prototype.version,
			// 保留原型指针
			_proto: $.extend( {}, prototype ),
			// 保留继承的轨迹
			_childConstructors: []
		});		

		//基类的实例
		basePrototype = new base();		
		basePrototype.options = $.component.extend( {}, basePrototype.options );
		//{prop: value}
		//如果value是一个方法
		$.each( prototype, function( prop, value ) {
			if ( $.isFunction( value ) ) {
				prototype[ prop ] = (function() {
					//借用基类的原型方法
					var _super = function() {
							return base.prototype[ prop ].apply( this, arguments );
						},
						//借用基类的原型方法（传入参数）
						_superApply = function( args ) {
							return base.prototype[ prop ].apply( this, args );
						};
					return function() {
						var __super = this._super,
							__superApply = this._superApply,
							returnValue;

						this._super = _super;
						this._superApply = _superApply;

						returnValue = value.apply( this, arguments );

						this._super = __super;
						this._superApply = __superApply;

						return returnValue;
					};
				})();
			}
		});

		constructor.prototype = $.component.extend( basePrototype, {
			widgetEventPrefix: existingConstructor ? basePrototype.widgetEventPrefix : name
		}, prototype, {
			constructor: constructor,
			namespace: namespace,
			widgetName: name,
			widgetBaseClass: fullName,
			widgetFullName: fullName
		});		

		if ( existingConstructor ) {
			$.each( existingConstructor._childConstructors, function( i, child ) {
				var childPrototype = child.prototype;
				$.component( childPrototype.namespace + "." + childPrototype.widgetName, constructor, child._proto );
			});
			delete existingConstructor._childConstructors;
		} else {
			base._childConstructors.push( constructor );
		}

		$.component.bridge( name, constructor );		

	};
	//component的静态扩展方法
	$.component.extend = function( target ) {
		//取出目标参数
		//target为plainObject时input和target应该相等
		var input = slice.call( arguments, 1 ),
			inputIndex = 0,
			inputLength = input.length,
			key,
			value;
		for ( ; inputIndex < inputLength; inputIndex += 1 ) {
			for ( key in input[ inputIndex ] ) {
				value = input[ inputIndex ][ key ];
				if ( input[ inputIndex ].hasOwnProperty( key ) && value !== undefined ) {
					// 克隆对象
					if ( $.isPlainObject( value ) ) {
						target[ key ] = $.isPlainObject( target[ key ] ) ?
							$.component.extend( {}, target[ key ], value ) :
							// 不扩展数组、字符串等对象
							$.component.extend( {}, value );
					// 复制所有的引用属性
					} else {
						target[ key ] = value;
					}
				}
			}
		}
		return target;
	};

	$.component.bridge = function( name, object ) {
		var fullName = object.prototype.widgetFullName || name;
		$.fn[ name ] = function( options ) {
			var isMethodCall = typeof options === "string",
				args = slice.call( arguments, 1 ),
				returnValue = this;

			// allow multiple hashes to be passed on init
			options = !isMethodCall && args.length ?
				$.widget.extend.apply( null, [ options ].concat(args) ) :
				options;

			if ( isMethodCall ) {
				this.each(function() {
					var methodValue,
						instance = $.data( this, fullName );
					if ( !instance ) {
						return $.error( "cannot call methods on " + name + " prior to initialization; " +
							"attempted to call method '" + options + "'" );
					}
					if ( !$.isFunction( instance[options] ) || options.charAt( 0 ) === "_" ) {
						return $.error( "no such method '" + options + "' for " + name + " widget instance" );
					}
					methodValue = instance[ options ].apply( instance, args );
					if ( methodValue !== instance && methodValue !== undefined ) {
						returnValue = methodValue && methodValue.jquery ?
							returnValue.pushStack( methodValue.get() ) :
							methodValue;
						return false;
					}
				});
			} else {
				this.each(function() {
					var instance = $.data( this, fullName );
					if ( instance ) {
						instance.option( options || {} )._init();
					} else {
						$.data( this, fullName, new object( options, this ) );
					}
				});
			}

			return returnValue;
		};
	};	

	//构造函数
	$.Component = function() {};
})( jQuery );
