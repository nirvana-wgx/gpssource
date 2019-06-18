/******************************************************************
 *easyTree的工具js Creater by Coollf
 *  2012-07-10
 */


   /**************************
    * 
    */

   /*****
    * 获取的复选框的值数组,当无有效节点背选中时返回 undefined
    */
   function getSelectedCheckboxValue(){
		var checkboxId="checkbox";
		var values=new Array();					
			$(":checkbox[name='"+checkboxId+"']:checked").each(function(i){
				var $this=$(this);
				if(!$this.attr('disabled')){
					values.push($this.val());
				}
			});
			if(values.length==0){
				alert('请选择一个节点');				
			}else{
				return values;
			}								
	};

	
	/****
	 * 获取的单选框的值数组,当无有效节点背选中时返回 undefined
	 * @returns {Array}
	 */
	function getSelectedRadioValue(){
		var radio_id='radio';
		var values=new Array();		
			//alert(":radio[name='"+radio_id+"']:checked");
			$(":radio[name='"+radio_id+"']:checked").each(function(i){
				var $this=$(this);
				if(!$this.attr('disabled')){
					values.push($this.val());
				}
			});
			if(values.length==0){
				alert('请选择一个节点');				
			}else{
				return values;
			}
	};
	
	/********************
	 * 查询过滤树节点 (需要在配置sql中做特殊处理)
	 * */
	function treeQuery(){					
		var query_key=$("#query_key").val();
		if(!query_key|| query_key==null){						
			query_key='';
		}else{						
			query_key=encodeURI(encodeURI(query_key));
		}
		var url=document.URL;
		if(url.indexOf('filter_key')==-1){			
			window.open(url+'&filter_key='+query_key,"_self");
		}else{						
			url=url.replace(/filter_key=[^&]*/,'filter_key='+query_key);
			window.open(url,"_self");									
		}
	}