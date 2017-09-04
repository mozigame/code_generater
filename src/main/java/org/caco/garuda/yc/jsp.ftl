<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>${comment}</title>
    <%@ include file="/system/_script.jsp"%>
	
	<style type="text/css">
      #fm{
          margin:0;
          padding:10px 20px;
      }
      .ftitle{
          font-size:14px;
          font-weight:bold;
          padding:5px 0;
          margin-bottom:10px;
          border-bottom:1px solid #ccc;
      }
      .fitem{
          margin-bottom:5px;
      }
      .fitem label{
          display:inline-block;
          width:60px;
      }
      .input_query{
      	width: 80px;
      }
      input,textarea {
	width: 160px;
	border: 1px solid #ccc;
	padding: 2px;
}
</style>
</head>

<body>
    
 	<div class="easyui-layout" data-options="fit:true">
    	<!-- 查询条件  -->
		<div data-options="region:'north', title:'${comment}-条件'"
			style="height: 80px; padding: 5px 80px;display:none;">
			<form id="search-form" >
				<table class="search-table">
					<tr>
						<#list columns as column>
						<#if column.search >
						<td>
							${column.comment}:
							<#if column.hasDict>
			                <input class="easyui-combobox" name="${column.fieldName}" id="query_${column.fieldName}" data-options="panelHeight:'auto',
											valueField: 'id',
											textField: 'name',
											//multiple:true, //多选增加此项
											data: <#if column.hasDictAll>getDictData(${column.dictKey},'all')<#else>${column.dictKey}</#if>" />
			                <#else>
			                <input type="text" id="query_${column.fieldName}" name="${column.fieldName}" <#if column.javaType == 'Date'>class="input_query"<#else>class="easyui-validatebox"</#if>>
			                </#if>
						</td>
						</#if>
						</#list>
						<td>
							<a class="easyui-linkbutton"
								data-options="iconCls:'icon-search'" id="search-btn">查询</a>
							<a class="easyui-linkbutton"
								data-options="iconCls:'icon-reload'" id="reset-btn">重置</a>
						</td>

					</tr>
				</table>
			</form>
		</div>
		
		<!-- 查询结果 center -->
	    <div data-options="region:'center', title:'查询结果'">
	    	<div id="toolbar" style="display:none;">
		        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="onAdd()">新增</a>
		        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="onEdit()">修改</a>
		        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="onDestroy()">删除</a>
		    </div>
		    <table id="dg" class="easyui-datagrid" data-options="onDblClickRow:onDblClick, onClickRow:onClick, onLoadSuccess:function(){$('.datagrid-btable').find('div.datagrid-cell').css('text-align','left');}"
		            url="/${simpleModule}/${entityName?uncap_first}/list"
		            toolbar="#toolbar" pagination="true"
		            rownumbers="true" fitColumns="true" singleSelect="true" style="display:none;">
		        <thead>
		            <tr >
		            	<%/* 
		            	<th align="center" field="cid" width="50" sortable="true">编号</th>
		            	*/ %>
		            	<#list columns as column>
							<#if column.showInGrid>
						<th align="center" field="${column.fieldName}" width="50" sortable="true"<#if column.hasDict> data-options="formatter: function(value,row,index){
									return renderDict(${column.dictKey}, value, false);
								}"</#if>>${column.comment}</th>
							<#if column.FK>
						<th align="center" field="${column.fkRelField}Name" width="50" sortable="true">${column.comment}</th>
							</#if>
						    </#if>
						</#list>
		            </tr>
		        </thead>
		    </table>
		 </div>
	</div>
    
    <div id="dlg" class="easyui-dialog" style="width:400px;height:500px;padding:5px 10px;display:none;"
            closed="true" buttons="#dlg-buttons">
	        <form id="fm" method="post" novalidate>
	        	<input type="hidden" name="cid">
	        	<#list columns as column>
				<#if column.showInGrid>
				<div class="fitem">
	                <label>${column.comment}:</label>
	                <#if column.hasDict>
	                <input class="easyui-combobox" name="${column.fieldName}" id="${entityName?uncap_first}_${column.fieldName}" required="true" data-options="panelHeight:'auto',
									valueField: 'id',
									textField: 'name',
									//multiple:true, //多选增加此项
									
									data: <#if column.hasDictAll>getDictData(${column.dictKey},'all')<#else>${column.dictKey}</#if>" />
	                <#else>
	                <input name="${column.fieldName}" <#if column.javaType == 'Date'>class="easyui-datebox"<#else>class="easyui-validatebox"</#if> required="true">
	                </#if>
	            </div>	
				</#if>
				</#list>
	        </form>
        <div id="dlg-buttons">
	        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="onSave()">Save</a>
	        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">Cancel</a>
	    </div>
    </div>
    
    <script type="text/javascript">
	    $('#search-btn').click(function(){
	    	doSearch();
		});
		$('#reset-btn').click(function(){
			$('#search-form')[0].reset();
		});
		
		function doSearch(){
        	var jsonParam = $('#search-form').serializeJson();
			$('#dg').datagrid('load', jsonParam);
        }
		
		
		
		function doSearchReload(){
        	var jsonParam = $('#search-form').serializeJson();
			$('#dg').datagrid('reload', jsonParam);
        }
		
		function onDblClick(rowIndex, rowData){
        	//alert('---onDblClick--rowIndex='+rowIndex+' row.cid='+rowData.cid);
        	onEdit();
        }
		
		function onClick(rowIndex, rowData){
        	
        }
		
		function listenerName(ex) {
	        if (ex.keyCode == 13) {                
	        	doSearch();
	        }
	    }
		$('#query_code').keydown(listenerName);
		$('#query_name').keydown(listenerName);
	
        var url;
        function onAdd(){
            $('#dlg').dialog('open').dialog('setTitle','New ${entityName}');
            $('#fm').form('clear');
            $('#${entityName?uncap_first}_status').combobox('select', '1');
            //$("#${entityName?uncap_first}_remark").val('test');
        }
        
        function getRowData(entityName, row){
        	var tmp;
        	var obj={}
        	obj[entityName]={};
        	for(i in row){
        		tmp = row[i];
        		obj[i]=tmp;
        	}
        	return obj;
        }
        function onEdit(){
            var row = $('#dg').datagrid('getSelected');
            if (row){
            	var entityName='${entityName?uncap_first}';
            	$('#fm').form('clear');
            	var obj = getRowData(entityName, row);
                $('#dlg').dialog('open').dialog('setTitle','Edit ${entityName}');
                $('#fm').form('load',obj);
            }
           
        }
        function onSave(){
        	var row = $('#dg').datagrid('getSelected');
            if (row){
            	if(row.canModify==0){
            		$.messager.show({
                        title: 'Error',
                        msg: '不可修改，禁止操作'
                    });
            		return;
            	}
            }
            $('#fm').form('submit',{
                url: '/${simpleModule}/${entityName?uncap_first}/save',
                onSubmit: function(){
                    return $(this).form('validate');
                },
                success: function(result){
                    var result = eval('('+result+')');
                    if (result.err=='SUCCESS' || result.err==''){
                        $('#dlg').dialog('close');        // close the dialog
                        $.messager.show({
                            title: result.err,
                            msg: result.msg
                        });
                        doSearchReload();    // reload the user data 
                    } else {
                        alert(result.err+":"+result.msg);
                    }
                }
            });
        }
        function onDestroy(){
            var row = $('#dg').datagrid('getSelected');
            if (row){
                $.messager.confirm('删除确认','你确定删除此记录?',function(r){
                    if (r){
                        $.post('/${simpleModule}/${entityName?uncap_first}/delete',{id:row.cid},function(result){
                            if (result.err=='SUCCESS' || result.err==''){
                            	$.messager.show({    // show error message
                                    title: '系统消息',
                                    msg: '删除成功'
                                });
                            	doSearchReload();    // reload the user data
                            } else {
                                $.messager.show({    // show error message
                                    title: 'Error',
                                    msg: result.msgBody
                                });
                            }
                        },'json');
                    }
                });
            } else {
            	$.messager.show({
                    title: '系统提示',
                    msg: '请先选择要删除的记录'
                });
            }
        }
    </script>
    <%@ include file="/system/_foot.jsp"%>
</body>
</html>