function _format(pattern,num,z){
	var j =	pattern.length >= num.length ? pattern.length : num.length ;
	var p = pattern.split("");
	var n = num.split("");
	var bool = true,nn = "";
	for(var i=0;i<j;i++){
		var x = n[n.length-j+i];
		var y = p[p.length-j+i];
		if( z == 0){
			if(bool){
				if( ( x && y && (x != "0" || y == "0")) || ( x && x != "0" && !y ) || ( y && y == "0" && !x )  ){
					nn += x ? x : "0";
					bool = false;
				}	
			} else {
				nn +=  x ? x : "0" ;
			}
		} else {
			if( y && ( y == "0" || ( y == "#" && x ) ))
				nn += x ? x : "0" ;								
		}
	}
	return nn;
}
function _formatNumber(numChar,pattern){
	var patterns = pattern.split(".");
	var	numChars = numChar.split(".");
	var z = patterns[0].indexOf(",") == -1 ? -1 : patterns[0].length - patterns[0].indexOf(",") ;
	var num1 = _format(patterns[0].replace(","),numChars[0],0);
	var num2 = _format(	patterns[1]?patterns[1].split('').reverse().join(''):"", numChars[1]?numChars[1].split('').reverse().join(''):"",1);
	num1 =	num1.split("").reverse().join('');
	var reCat = eval("/[0-9]{" + (z-1) + "," + (z-1) + "}/gi");
	var arrdata = z > -1 ? num1.match(reCat) : undefined ;
	if( arrdata && arrdata.length > 0 ){
		var w =	num1.replace(arrdata.join(''),'');
		num1 = arrdata.join(',') + ( w == "" ? "" : "," ) + w ;
	}
	num1 = num1.split("").reverse().join("");
	return (num1 == "" ? "0" : num1) + (num2 != "" ? "." + num2.split("").reverse().join('') : "" ); 					
} 
function formatNumber(num,opt){
	var reCat = /[0#,.]{1,}/gi;
	var zeroExc = opt.zeroExc == undefined ? true : opt.zeroExc ;
	var pattern = opt.pattern.match(reCat)[0];
	var numChar = num.toString();
	return !(zeroExc && numChar == 0) ? opt.pattern.replace(pattern,_formatNumber(numChar,pattern)) : opt.pattern.replace(pattern,"0");
}

function toNumber(numStr){
	var numberPattern = /\d+(,(\d)+)*(.(\d)+)?/;
	var result = numStr.match(numberPattern);
	if(!result){
	  return NaN;
	}else{
	  return parseFloat(result[0].replace(new RegExp(",", "g"), ""));
	}
}


/**
 * ============================================================================================
 * ��JS�ļ��Ǹ�ʽ��JS������ʱ��Ĺ����࣬���а����˴������ڶ���Date����ʽ������Ҫ�ĸ�ʽ��<br>
 * ���ߴ����ַ�����ʽ��ʱ��������ַ������ڶ�Ӧ�ĸ�ʽ����ת��Ϊ��Ӧ�����ڶ���<br>
 * ���Լ�����������֮��Ĳ�ֵ
 * 
 * y: ��ʾ��
 * M����ʾһ���е��·� 1~12
 * d: ��ʾ�·��е����� 1~31
 * H����ʾһ���е�Сʱ�� 00~23
 * m: ��ʾСʱ�еķ����� 00~59
 * s: ��ʾ�����е�����   00~59
 * ============================================================================================
 */
  
  var DateFormat = function(bDebug){
      this.isDebug = bDebug || false;
      this.curDate = new Date();
  }
 
 DateFormat.prototype = {
    //����һЩ���õ����ڸ�ʽ�ĳ���
    DEFAULT_DATE_FORMAT: 'yyyy-MM-dd',
	DEFAULT_MONTH_FORMAT: 'yyyy-MM',
	DEFAULT_YEAR_FORMAT: 'yyyy',
	DEFAULT_TIME_FORMAT: 'HH:mm:ss',
	DEFAULT_DATETIME_FORMAT: 'yyyy-MM-dd HH:mm:ss',
    DEFAULT_YEAR: 'YEAR',
	DEFAULT_MONTH: 'MONTH',
	DEFAULT_DATE: 'DATE',
	DEFAULT_HOUR: 'HOUR',
	DEFAULT_MINUTE: 'MINUTE',
	DEFAULT_SECOND: 'SECOND',
	
	/**
	 * ���ݸ���������ʱ���ʽ����ʽ����ǰ����
	 * @params strFormat ��ʽ���ַ����� �磺"yyyy-MM-dd" Ĭ�ϸ�ʽΪ����yyyy-MM-dd HH:mm:ss��
	 * @return ���ظ��ݸ�����ʽ���ַ�����ʾ��ʱ�����ڸ�ʽ<br>
	 *         ������벻�Ϸ��ĸ�ʽ���򷵻����ڵ��ַ�����ʽ{@see Date#toLocaleString()}
	 */
	 formatCurrentDate: function(strFormat){
	   try{
	      var tempFormat = strFormat == undefined? this.DEFAULT_DATETIME_FORMAT: strFormat;
	      var dates = this.getDateObject(this.curDate);
		  if(/(y+)/.test(tempFormat)){
			 var fullYear = this.curDate.getFullYear() + '';
			 var year = RegExp.$1.length == 4? fullYear: fullYear.substr(4 - RegExp.$1.length);
			 tempFormat = tempFormat.replace(RegExp.$1, year);
		  }
		  for(var i in dates){
			 if(new RegExp('(' + i + ')').test(tempFormat)){
				var target = RegExp.$1.length == 1? dates[i]: ('0' + dates[i]).substr(('' + dates[i]).length - 1);
				tempFormat = tempFormat.replace(RegExp.$1, target);
			 }
		  }
          return tempFormat === strFormat? this.curDate.toLocaleString(): tempFormat;
	   }catch(e){
	      this.debug('��ʽ�����ڳ����쳣��' + e.message);
	   }
	},
	
	
	/**
	 * ���ݸ����ĸ�ʽ���Ѹ�����ʱ����и�ʽ��
	 * @params date Ҫ��ʽ��������
	 * @params strFormat Ҫ�õ������ڵĸ�ʽ�ĸ�ʽ���ַ������磺'yyyy-MM-dd'��Ĭ�ϣ�yyyy-MM-dd HH:mm:ss
	 * @return ���ݹ涨��ʽ��ʱ���ʽ
	 *  
	 * @updateDate 2011-09-15
	 */
	format: function(date, strFormat){
	 try{
		if(date == undefined){
		   this.curDate = new Date();
		}else if(!(date instanceof Date)){
		   this.debug('�������date:' + date + '������������');
		   return date;
		}else{
		   this.curDate = date;
		}
		return this.formatCurrentDate(strFormat);
	 }catch(e){
	    this.debug('��ʽ�����ڳ����쳣��' + e.message);
	 }
	},
	
	/**
	 * ���ݸ����ĸ�ʽ�Ը������ַ�������ʱ����н�����
	 * @params strDate Ҫ���������ڵ��ַ�����ʾ,�˲���ֻ�����ַ�����ʽ�����ڣ����򷵻ص���ϵͳ����
	 * @params strFormat �����������ڵ�˳��, ��������strDate�ĸ�ʽΪ{Date.parse()}����֧�ֵĸ�ʽ��<br>
	 *         ����Բ����룬����һ��Ҫ������strDate��Ӧ�ĸ�ʽ, ���������ʽ�򷵻ص���ϵͳ���ڡ�
	 * @return ���ؽ������Date���͵�ʱ��<br>
	 *        �����ܽ����򷵻ص�ǰ����<br>
	 *        ������Ϊʱ���ʽ �򷵻ص�����Ϊ 1970��1��1�յ�����
	 *
	 * bug: �˷���Ŀǰֻ��ʵ������'yyyy-MM-dd'��ʽ�����ڵ�ת����<br>
	 *       ��'yyyyMMdd'��ʽ�����ڣ�����ʵ��
	 */
	 
	parseDate: function(strDate, strFormat){
	   if(typeof strDate != 'string'){
			return new Date();
	   }
	  var longTime = Date.parse(strDate);
	  if(isNaN(longTime)){
	      if(strFormat == undefined){
		      this.debug('���������ڵĸ�ʽ');
		     return new Date();
		  }
		  var tmpDate = new Date();
		  var regFormat = /(\w{4})|(\w{2})|(\w{1})/g;
		  var regDate = /(\d{4})|(\d{2})|(\d{1})/g;
		  var formats = strFormat.match(regFormat);
		  var dates = strDate.match(regDate);
		  if( formats != undefined &&  dates != undefined && formats.length == dates.length){
		    for(var i = 0; i < formats.length; i++){
			  var format = formats[i];
			  if(format === 'yyyy'){
				tmpDate.setFullYear(parseInt(dates[i], 10));
			  }else if(format == 'yy'){
				var prefix = (tmpDate.getFullYear() + '').substring(0, 2);
				var year = (parseInt(dates[i], 10) + '').length == 4? parseInt(dates[i], 10): prefix + (parseInt(dates[i], 10) + '00').substring(0, 2);
				var tmpYear = parseInt(year, 10);
				tmpDate.setFullYear(tmpYear);
			  }else if(format == 'MM' || format == 'M'){
				tmpDate.setMonth(parseInt(dates[i], 10) - 1);
			  }else if(format == 'dd' || format == 'd'){
				tmpDate.setDate(parseInt(dates[i], 10));
			  }else if(format == 'HH' || format == 'H'){
				tmpDate.setHours(parseInt(dates[i], 10));
			  }else if(format == 'mm' || format == 'm'){
				tmpDate.setMinutes(parseInt(dates[i], 10));
			  }else if(format == 'ss' || format == 's'){
				tmpDate.setSeconds(parseInt(dates[i], 10));
			  }
		    }
		   return tmpDate;
		 }
		  return tmpDate;
	    }else{
	      return new Date(longTime);
	    }
    },
	
	
	/**
	 * ���ݸ�����ʱ�������ͼ����ֵ���Ը����ĸ�ʽ�Ը�����ʱ����м��㲢��ʽ������
	 * @params date Ҫ����������ʱ�����Ϊʱ����ַ�������{@see Date}���Ƶ�ʱ�����
	 * @params interval ʱ���������磺"YEAR"��"MONTH"�� "DATE", �����ִ�Сд
	 * @params amount ʱ����ֵ�����������͸���, ����Ϊ��date�����ڼ�ȥ��Ӧ����ֵ������Ϊ��date�������ϼ�����Ӧ����ֵ
	 * @params strFormat ������˵�date�ĸ�ʽΪ�ַ����ǣ�����������롣��date����Ϊ{@see Date}�����Ǵ������Ϊ��������ĸ�ʽ��
	 * @params targetFormat �������������ʱ��ĸ�ʽ����û��������ʹ��strFormat����Ĭ�ϸ�ʽ'yyyy-MM-dd HH:mm:ss'
	 * @return ���ؼ��㲢��ʽ�����ʱ����ַ���
	 */
	changeDate: function(date, interval, amount, strFormat, targetFormat){
		var tmpdate = new Date();
	    if(date == undefined){
		   this.debug('�����ʱ�䲻��Ϊ��!');
		   return new Date();
		}else if(typeof date == 'string'){
			tmpdate = this.parseDate(date, strFormat);
		}else if(date instanceof Date){
		  tmpdate = date;
		}
		var field  =  (typeof interval == 'string')? interval.toUpperCase(): 'DATE';
		
		try{
		  amount = parseInt(amount + '', 10);
		  if(isNaN(amount)){
		     amount = 0;
		  }
		}catch(e){
		   this.debug('�������[amount=' + amount + ']����ת��Ϊ����');
		   amount = 0;
		}
		switch(field){
		   case this.DEFAULT_YEAR:
		     tmpdate.setFullYear(tmpdate.getFullYear() + amount);
		     break;
		   case this.DEFAULT_MONTH:
		     tmpdate.setMonth(tmpdate.getMonth() + amount);
		     break;
		   case this.DEFAULT_DATE:
		     tmpdate.setDate(tmpdate.getDate() + amount);
		     break;
		   case this.DEFAULT_HOUR:
		     tmpdate.setHours(tmpdate.getHours() + amount);
		     break;
		   case this.DEFAULT_MINUTE:
		     tmpdate.setMinutes(tmpdate.getMinutes() + amount);
		     break;
		   case this.DEFAULT_SECOND:
		      tmpdate.setSeconds(tmpdate.getSeconds() + amount);
		     break;
		   default:
		      this.debug('�������[interval:' + field + '] ����������!');		
		}
		
	    this.curDate = tmpdate;
		return this.formatCurrentDate(targetFormat == undefined? strFormat: targetFormat);
	},
	
	/**
	 * �Ƚ��������ڵĲ��
	 * @param date1 Date���͵�ʱ��
	 * @param date2 Dete ���͵�ʱ��
	 * @param isFormat boolean �Ƿ�Եó���ʱ����и�ʽ��,<br> 
	 *       false:���غ�������true�����ظ�ʽ���������
	 * @return ������������֮��ĺ����� �����Ǹ�ʽ����Ľ��
	 */
	compareTo: function(date1, date2, isFormat){
	  try{
			var len = arguments.length;
			var tmpdate1 = new Date();
			var tmpdate2 = new Date();
			if(len == 1){
			   tmpdate1 = date1;
			}else if(len >= 2){
			  tmpdate1 = date1;
			  tmpdate2 = date2;
			}
		if(!(tmpdate1 instanceof Date) || !(tmpdate2 instanceof Date)){
		   return 0;
		}else{
			var time1 = tmpdate1.getTime(); 
			var time2 = tmpdate2.getTime();
			var time = Math.max(time1, time2) - Math.min(time1, time2);
			if(!isNaN(time) && time > 0){
			   if(isFormat){
				  var date = new Date(time);
				  var result = {};
				  result['year']   = (date.getFullYear() - 1970) > 0? (date.getFullYear() - 1970): '0';
				  result['month']  = (date.getMonth() - 1) > 0? (date.getMonth() - 1): '0';
				  result['day']    = (date.getDate() - 1) > 0? (date.getDate() - 1): '0';
				  result['hour']   = (date.getHours() - 8) > 0? (date.getHours() - 1): '0';
				  result['minute'] = date.getMinutes() > 0? date.getMinutes(): '0';
				  result['second'] = date.getSeconds() > 0? date.getSeconds(): '0';
				  return result;
				}else {
				 return time;
				}
			}else{
			  return 0;
			}
		}
	  }catch(e){
	    this.debug('�Ƚ�ʱ������쳣' + e.message);
	  }
	},
	
	/**
	 * ���ݸ��������ڵõ����ڵ��£��գ�ʱ���ֺ���Ķ���
	 * @params date ���������� dateΪ��Date���ͣ� ���ȡ��ǰ����
	 * @return �и������ڵ��¡��ա�ʱ���ֺ�����ɵĶ���
	 */
	getDateObject: function(date){
		 if(!(date instanceof Date)){
		   date = new Date();
		 }
		return {
			'M+' : date.getMonth() + 1, 
			'd+' : date.getDate(),   
			'H+' : date.getHours(),   
			'm+' : date.getMinutes(), 
			's+' : date.getSeconds()
		 };
	},
	
	/**
	 *�ڿ���̨�����־
	 *@params message Ҫ�������־��Ϣ
	 */
	debug: function(message){
	   try{
	       if(!this.isDebug){
		     return;
		   }
	       if(!window.console){
		       window.console = {};
		       window.console.log = function(){
		          return;
		       }
		   }
	       window.console.log(message + ' ');
	   }catch(e){
	   }
	}
}