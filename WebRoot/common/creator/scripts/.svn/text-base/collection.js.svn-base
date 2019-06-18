/**
 * js构建的一些集合对象（仿java）
 * 
 */


/**
  * js实现List
  * 
  * 接口有
  * list.add(obj);
  * list.size();
  * list.get(i);
  * list.remove(i);
  * list.removeAll();
  * list.contains(obj);
  * list.isEmpty();
  * 
  */
function List(){
 
    this.value = [];
      
    /*添加*/
    this.add = function(obj){
        return this.value.push(obj);
    };
     
    /*大小*/
    this.size = function(){
        return this.value.length;
    };
 
    /*返回指定索引的值*/
    this.get = function(index){
        return this.value[index];
    };
 
    /*删除指定索引的值*/
    this.remove = function(index){
        this.value1 = [];                          
        this.value[index]='';                      
        for(var i=0;i<this.size();i++){
            if(this.value[i]!=''){                 
                this.value1.push(this.value[i]);
            }
        }
        this.value = this.value1;  
        delete this.value1;        
        return this.value;         
    };
     
    /*删除全部值*/
    this.removeAll = function(){
        return this.value=[];          
    };
    
    /*是否为空*/
    this.isEmpty = function(){
    	return this.value.length == 0;
    };
 
    /*是否包含某个对象*/
    this.constains = function(obj){
        for(var i in this.value){      
            if( obj == this.value[i] ){
                return true;
            }else{                     
                continue;
            }
        }
        return false;              
    };
    
    /*重写toString()*/
    this.toString = function() { 
        return this.value.join(",");
    };
 
}

/**
 * js Map 实现
 * 接口有
 * map.put(key,value);
 * map.get(key);
 * map.contains(key);
 * map.remove(key);
 * map.each(function(){});
 * map.entrySet(); 返回键值对数组，格式如[{key1:value1},{key2:value2}]
 * map.isEmpty();
 * map.size();
 * map.toString();
 * @returns {Map}
 */
function Map() {
    this.keys = [];
    this.data = {};
 
    /**
     * 放入一个键值对
     * @param {String} key
     * @param {Object} value
     */
    this.put = function(key, value) {
        if (this.data[key] == null) {
            this.keys.push(key);
        }
        this.data[key] = value;
    };
 
    /**
     * 获取某键对应的值
     * @param {String}  key
     * @return {Object} value
     */
    this.get = function(key) {
        return this.data[key];
    };
 
    /**
     * 是否包含该键
     */
    this.contains = function(key) {
        
        var value = this.data[key];
        if (value)
            return true;
        else
            return false;
    };
 
    /**
     * 删除一个键值对
     * @param {String} key
     */
    this.remove = function(key) {
        for(var index=0;index<this.keys.length;index++){
            if(this.keys[index]==key){
                this.keys.splice(index,1);
                break;
            }
        }
        //this.keys.remove(key);
        this.data[key] = null;
    };
 
    /**
     * 遍历Map,执行处理函数
     * @param {Function} 回调函数 function(key,value,index){..}
     */
    this.each = function(fn) {
        if (typeof fn != 'function') {
            return;
        }
        var len = this.keys.length;
        for ( var i = 0; i < len; i++) {
            var k = this.keys[i];
            fn(k, this.data[k], i);
        }
    };
 
    /**
     * 获取键值数组(类似Java的entrySet())
     * @return 键值对象{key,value}的数组
     */
    this.entrySet = function() {
        var len = this.keys.length;
        var entrys = new Array(len);
        for ( var i = 0; i < len; i++) {
            entrys[i] = {
                key : this.keys[i],
                value : this.data[i]
            };
        }
        return entrys;
    };
 
    /**
     * 判断Map是否为空
     */
    this.isEmpty = function() {
        return this.keys.length == 0;
    };
 
    /**
     * 获取键值对数量
     */
    this.size = function() {
        return this.keys.length;
    };
 
    /**
     * 重写toString
     */
    this.toString = function() {
        var s = "{";
        for ( var i = 0; i < this.keys.length; i++, s += ',') {
            var k = this.keys[i];
            s += k + "=" + this.data[k];
        }
        s += "}";
        return s;
    };
    
    this.keySet = function() {
    	return this.keys;
    };
}
