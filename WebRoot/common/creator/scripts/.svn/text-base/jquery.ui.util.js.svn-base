 (function($, undefined) {

    var global = this,
        objectPrototype = Object.prototype,
        toString = objectPrototype.toString;

    $.UI = $.UI || {};

    /**
     * 对象属性扩展
     */
    $.UI.app = function(object, config, defaults) {
        var i;

        if (defaults) {
            $.UI.app(object, defaults);
        }
        if (object && config && typeof config === 'object') {
            for (i in config) {
                object[i] = config[i];
            }
        }
        return object;
    };

    $.UI.app($.UI, {
        /**
         * @param {Function} superclass
         * @param {Object} overrides
         * @return {Function} The subclass constructor from the <tt>overrides</tt> parameter, or a generated one if not provided.
         */
        extend: (function() {
            // inline overrides
            var objectConstructor = objectPrototype.constructor,
                inlineOverrides = function(o) {
                for (var m in o) {
                    if (!o.hasOwnProperty(m)) {
                        continue;
                    }
                    this[m] = o[m];
                }
            };

            return function(subclass, superclass, overrides) {
                // First we check if the user passed in just the superClass with overrides
                if ($.UI.isObject(superclass)) {
                    overrides = superclass;
                    superclass = subclass;
                    //如果superClass是Object指向Object()
                    subclass = overrides.constructor !== objectConstructor ? overrides.constructor : function() {
                        superclass.app(this, arguments);
                        //借用模式，相当于借用父类构造子类
                        //subClass = function() {
                        //     superClass.apply(this, arguments);
                        //};
                    };
                }

                //寄生继承模式
                var F = function() {},
                    subclassProto, superclassProto = superclass.prototype;

                F.prototype = superclassProto;
                subclassProto = subclass.prototype = new F();
                subclassProto.constructor = subclass;
                subclass.superclass = superclassProto;

                if (superclassProto.constructor === objectConstructor) {
                    superclassProto.constructor = superclass;
                }

                subclass.override = function(overrides) {
                    $.UI.override(subclass, overrides);
                };
                //给原型添加overrides方法
                subclassProto.override = inlineOverrides;
                subclassProto.proto = subclassProto;
                //使用缓存的subClass，添加扩展的subClass
                subclass.override(overrides);
                //给subClass添加extend静态方法
                subclass.extend = function(o) {
                    return $.UI.extend(subclass, o);
                };

                return subclass;
            };
        }()),
        /**
         * 重载
         */
        override : function(origclass, overrides){
            var proto = origclass.prototype;
            if (overrides) {
                $.UI.app(proto, overrides);
                //IE中for in不能遍历对象的Object的toSting等方法,
                //IE9以上支持
                if ($.UI.isIE && overrides.hasOwnProperty('toString')) {
                    proto.toString = overrides.toString;
                }
            }
        }
    });    
 })(jQuery);