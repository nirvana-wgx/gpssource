
	
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

// ��ť��
// tileΪ���ͣ��ʱ����
// innerTextΪ��ǰ��ť���֣�innerchangeΪ�����ť��ı�ɵ�����
// ����������ı����֣���innerText��innerChange���ó�һ������
// indexΪ��ť�����
function BottonControl( map, title, innerText, innerChange, nIndex) 
{
	
	controlDiv = document.createElement('DIV');
	controlDiv.style.padding = '5px';
	// ����UI
	controlUI = document.createElement('DIV');
	controlUI.style.backgroundColor = 'white';
	controlUI.style.borderStyle = 'solid';
	controlUI.style.borderWidth = '2px';
	controlUI.style.cursor = 'pointer';
	controlUI.style.textAlign = 'center';
	controlUI.title = title;
	controlUI.id = 'controlUI';
	
	// �Ӹ���ͼ����
	controlUI.map = map;
	// ��¼��ť�ϵ�����
	controlUI.text = innerText;
	controlUI.change = innerChange;
	
	// ��ǰ״̬,Ĭ��Ϊ0
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

	// ���°�ť֮��ִ�еĺ�������ͬ�Ĺ�����Ҫ��д�������
	controlUI.ActionFunc = function() 
	{
		
	};
	
	this.controlUI = controlUI;
	
	// ������Ӧ
	google.maps.event.addDomListener(controlUI, 'click', ClickFunc);

	// ��������ͼ
	controlDiv.index = nIndex;
	map.controls[google.maps.ControlPosition.TOP_CENTER].push(controlDiv);
}

