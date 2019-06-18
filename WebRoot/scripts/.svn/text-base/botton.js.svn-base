
	
function ClickFunc()
{
	var child = this.childNodes[0];
	
	if(child.innerHTML == this.text)
	{
		child.innerHTML = this.change;
	}
	else
	{
		child.innerHTML = this.text;	
	}

	this.ActionFunc(this.map);
};

// 按钮类
// tile为鼠标停留时文字
// innerText为当前按钮文字，innerchange为点击按钮后改变成的文字
// 如果点击不想改变文字，则innerText和innerChange设置成一样即可
// index为按钮的序号
function BottonControl( map, title, innerText, innerChange, nIndex) 
{
	
	controlDiv = document.createElement('DIV');
	controlDiv.style.padding = '5px';
	// 创建UI
	controlUI = document.createElement('DIV');
	controlUI.style.backgroundColor = 'white';
	controlUI.style.borderStyle = 'solid';
	controlUI.style.borderWidth = '2px';
	controlUI.style.cursor = 'pointer';
	controlUI.style.textAlign = 'center';
	controlUI.title = title;
	controlUI.id = 'controlUI';
	
	// 加个地图属性
	controlUI.map = map;
	// 记录按钮上的文字
	controlUI.text = innerText;
	controlUI.change = innerChange;
	
	// 当前状态,默认为0
	controlUI.status = 0;
	
	controlDiv.appendChild(controlUI);
	
	controlText = document.createElement('DIV');
	controlText.style.fontFamily = 'Arial,sans-serif';
	controlText.style.fontSize = '12px';
	controlText.style.paddingLeft = '18px';
	controlText.style.paddingRight = '18px';
	controlText.id = 'controlText';
	controlText.innerHTML = innerText;
	controlUI.appendChild(controlText);	

	// 按下按钮之后执行的函数，不同的功能需要重写这个函数
	controlUI.ActionFunc = function() 
	{
		
	};
	
	this.controlUI = controlUI;
	
	// 按键响应
	google.maps.event.addDomListener(controlUI, 'click', ClickFunc);

	// 关联到地图
	controlDiv.index = nIndex;
	map.controls[google.maps.ControlPosition.TOP_CENTER].push(controlDiv);
}

