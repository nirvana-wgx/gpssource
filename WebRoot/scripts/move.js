
function setIndex(index) {
        // 将前一小车隐藏
	if (PreIndex >= 0) {
		MoveMarkers[PreIndex].setIcon(imageChg);
	}
        // 显示当前选择的小车
	if (MoveMarkers[index - 1] != null) {
		MoveMarkers[index - 1].setIcon(image);
		PreIndex = index - 1;
		map.setCenter(MoveNodes[index - 1]);
	}
}

//==========标签类=========
function Label(opt_options) {

        // 设定属性，主要是设定map
	this.setValues(opt_options);

        // 标签字体
	var span = this.span_ = document.createElement("span");
	span.style.cssText = "position: relative; left: 0%; top: 1px; " + "white-space: nowrap; border: 1px; font-family:arial; font-weight:bold;" + "padding: 2px; background-color: #0ff; " + "opacity: .75; " + "filter: alpha(opacity=75); " + "-ms-filter: \"alpha(opacity=75)\"; " + "-khtml-opacity: .75; " + "-moz-opacity: .75;";
	var div = this.div_ = document.createElement("div");
	div.appendChild(span);
	div.style.cssText = "position: absolute; display: none";
}
Label.prototype = new google.maps.OverlayView;

    // 添加标签
Label.prototype.onAdd = function () {
	var pane = this.getPanes().overlayLayer;
	pane.appendChild(this.div_);

    
        // 当内容发生改变时，重新绘制
	var me = this;
	this.listeners_ = [google.maps.event.addListener(this, "position_changed", function () {
		me.draw();
	}), google.maps.event.addListener(this, "text_changed", function () {
		me.draw();
	})];
};

    // 移除标签
Label.prototype.onRemove = function () {
	this.div_.parentNode.removeChild(this.div_);
        // 移除标签后，要移除相应的监听器
	for (var i = 0, I = this.listeners_.length; i < I; ++i) {
		google.maps.event.removeListener(this.listeners_[i]);
	}
};

    // 绘制标签
Label.prototype.draw = function () {
	var projection = this.getProjection();
	var position = projection.fromLatLngToDivPixel(this.get("position"));
	var div = this.div_;
	div.style.left = position.x + "px";
	div.style.top = position.y + "px";
	div.style.display = "block";
	this.span_.innerHTML = this.get("text").toString();
};
//========标签类结束===========

// 初始化动画路径
function initMoveNode() {       
        // 动画路径样式
	MovePolyOptions = {strokeColor:"#FF0000", strokeOpacity:0.5, strokeWeight:5};
        
        // 动画路径
	MovePoly = new google.maps.Polyline(MovePolyOptions);
	MovePoly.setMap(map);
    
        // 动画开关
	MoveOn = 0;
   
        // 添加节点
        //var myLatlng  = map.getCenter(); 
	var lat = 28.12345;
	var lon = 112.59123;
	var curLatlng;
	for (var i = 0; i < 20; i = i + 1) {
		curLatlng = new google.maps.LatLng(lat, lon);
		MoveNodes.push(curLatlng);
		lat = lat + 0.2;
		lon = lon + 0.3;
	}
}
function clearNode() {
        // 重新构建运动轨迹
	MovePoly.setMap(null);
	MovePoly = new google.maps.Polyline(MovePolyOptions);
	MovePoly.setMap(map);
        
        // 清空节点标记
	for (var i = 0; i < MoveMarkers.length; i++) {
		MoveMarkers[i].setMap(null);
		MoveMarkers[i] = null;
		LabelArray[i].setMap(null);
		LabelArray[i] = null;
	}
	MoveMarkers = [];
	LabelArray = [];
        // 前一个轨迹点
	PreIndex = -1;
}

// 播放动画
function playMoveNode() {
        // 当前序号（动画过程中）
	playCount = 0; 
        // 清空动画轨迹
	clearNode();
        // 设置播放时间间隔及其回调函数
	setTimeout(playtimer, 3500);
}

// 动画回调函数
function playtimer() {
        // 当前播放序号小于总节点数，则继续播放
	if (playCount < MoveNodes.length) {
            // 设置动画路径的数据
		var path = MovePoly.getPath();
		path.push(MoveNodes[playCount]);
		MovePoly.setMap(map);
		map.setCenter(MoveNodes[playCount]);
            // 创建图标
		var mk = new google.maps.Marker({position:MoveNodes[playCount], map:map, icon:image});
		mk.CurNum = playCount + 1;
		if (PreIndex >= 0) {
			MoveMarkers[PreIndex].setIcon(imageChg);
		}
		PreIndex = playCount;
            // 创建一个标签，绑定到当前的图标上
		var MarkerNum = new Label({map:map});
		MarkerNum.bindTo("position", mk, "position");
            // 设定标签的信息
		MarkerNum.set("text", mk.CurNum);
		MoveMarkers.push(mk);
		LabelArray.push(MarkerNum);
            // 图标设置到地图中
		mk.setMap(map);
  
            // 动画序号增加
		playCount++;
            // 播放下一节点
		setTimeout(playtimer, 500);
	}
}

